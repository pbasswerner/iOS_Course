import Foundation
import UIKit
import SpotifyiOS

class SpotifyService: NSObject {
    static let shared = SpotifyService() // Singleton instance
    
    var appRemote: SPTAppRemote
    var sessionManager: SPTSessionManager?
    private let configuration: SPTConfiguration
    
    private var connectionAttempts = 0
    private let maxConnectionAttempts = 3
    
    var accessToken: String? {
        didSet {
            UserDefaults.standard.set(accessToken, forKey: accessTokenKey)
            appRemote.connectionParameters.accessToken = accessToken
        }
    }
    
    // MARK: - Spotify Authorization & Configuration
    var responseCode: String? {
        didSet {
            fetchAccessToken { (dictionary, error) in
                if let error = error {
                    print("Fetching token request error \(error)")
                    return
                }
                let accessToken = dictionary!["access_token"] as! String
                DispatchQueue.main.async {
                    self.appRemote.connectionParameters.accessToken = accessToken
                    self.appRemote.connect()
                    print("response code")
                }
            }
        }
    }
    
    
    override init() {
        //Configuration set up
        print("configuration set up caled")
        self.configuration = SPTConfiguration(clientID: spotifyClientId, redirectURL: redirectUri)
        //self.configuration.playURI = "spotify:track:7sq2z9oX2S0CvgTqCZ0ko4"
        self.configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        self.configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        
        
        self.appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        self.accessToken = UserDefaults.standard.string(forKey: accessTokenKey)
        
        super.init()
        
        self.appRemote.delegate = self
        self.sessionManager = SPTSessionManager(configuration: configuration, delegate: self)
        
    }
    
    
    func playTrack(trackID: String) {
        
        let trackURI = "spotify:track:\(trackID)"
        self.appRemote.authorizeAndPlayURI(trackURI)
        appRemote.playerAPI?.play(trackURI, callback: { (result, error) in
            if let error = error {
                print("Error playing track: \(error.localizedDescription)")
            } else {
                print("Playing track \(trackID)")
            }
        })
    }
    
    
    func handleURL(_ url: URL) {
        print("handle url called")
        let parameters = appRemote.authorizationParameters(from: url)
        if let code = parameters?["code"] {
            // Assume you exchange the code for an access token here or handle the code
            print("Authorization code received: \(code)")
        } else if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("Spotify authentication error: \(errorDescription)")
        }
        
        
    }
    
    func initiateSession() {
        print("initiate session called")
        guard let sessionManager = sessionManager else { return }
        let scopes: SPTScope = [.appRemoteControl, .playlistReadPrivate, .userFollowRead, .userLibraryRead, .userReadPrivate, .userReadEmail]
        sessionManager.initiateSession(with: scopes, options: .clientOnly)
    }
    
    func connect() {
        guard let accessToken = accessToken, !accessToken.isEmpty else { return }
        
        guard connectionAttempts < maxConnectionAttempts else{
            print("Maximum retry attempts reached, stopping further attempts.")
            return
        }
        if !appRemote.isConnected {
            appRemote.connect()
        }
        
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    
    func fetchArtwork(for track: SPTAppRemoteTrack, completion: @escaping (UIImage?) -> Void) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize(width: 300, height: 300), callback: { (image, error) in
            if let error = error {
                print("Error fetching artwork: \(error.localizedDescription)")
                completion(nil)
            } else if let image = image as? UIImage {
                completion(image)
            } else {
                print("Failed to cast image.")
                completion(nil)
            }
        })
    }
    
    func fetchAccessToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
        print("fetch token method called")
        
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((spotifyClientId + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
                                       "Content-Type": "application/x-www-form-urlencoded"]
        
        var requestBodyComponents = URLComponents()
        let scopeAsString = stringScopes.joined(separator: " ")
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "client_id", value: spotifyClientId),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: responseCode!),
            URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString),
            URLQueryItem(name: "code_verifier", value: ""), // not currently used
            URLQueryItem(name: "scope", value: scopeAsString),
        ]
        
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                print("Error fetching token \(error?.localizedDescription ?? "")")
                return completion(nil, error)
            }
            let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            print("Access Token Dictionary=", responseObject ?? "")
            completion(responseObject, nil)
        }
        task.resume()
    }
    
    func fetchSongRecommendationForMood(minValence: Float, maxValence: Float, minEnergy: Float, maxEnergy: Float, completion: @escaping (Result<[Track], Error>) -> Void) {
        guard let accessToken = self.appRemote.connectionParameters.accessToken else {
            completion(.failure(NSError(domain: "SpotifyService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token is nil"])))
            return
        }
        
        let url = URL(string: "https://api.spotify.com/v1/recommendations")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "1"),
            URLQueryItem(name: "seed_genres", value: "latin"), // Example genre
            URLQueryItem(name: "min_valence", value: String(minValence)),
            URLQueryItem(name: "max_valence", value: String(maxValence)),
            URLQueryItem(name: "min_energy", value: String(minEnergy)),
            URLQueryItem(name: "max_energy", value: String(maxEnergy))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "SpotifyService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recommendations = try decoder.decode(RecommendationResponse.self, from: data)
                completion(.success(recommendations.tracks))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}

extension SpotifyService: SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { success, error in })
        print("Connected to Spotify")
                connectionAttempts = 0 // reset attempts on successful connection
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Disconnected from Spotify")
        attemptReconnect(appRemote)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Failed to connect to Spotify")
        connectionAttempts += 1
               DispatchQueue.main.asyncAfter(deadline: .now() + (Double(connectionAttempts) * 2.0)) {
                   self.connect() // Retry connection
               }
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("Spotify Track name: \(playerState.track.name)")
        print("Player state changed")
        
    }
    
    private func attemptReconnect(_ appRemote: SPTAppRemote) {
        guard !appRemote.isConnected else {
            return
        }
        appRemote.connect()  // Attempt to reconnect
    }
}

extension SpotifyService: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Session Manager failed with error: \(error.localizedDescription)")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Session renewed")
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        accessToken = session.accessToken
        connect()
    }
}


extension SpotifyService {
    
    func playOrPauseTrack() {
        appRemote.playerAPI?.getPlayerState { [weak self] playerState, error in
            guard let self = self, let playerState = playerState as? SPTAppRemotePlayerState, error == nil else {
                print("Error fetching player state: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            if playerState.isPaused {
                self.appRemote.playerAPI?.resume { _, error in
                    if let error = error {
                        print("Error resuming playback: \(error.localizedDescription)")
                    } else {
                        print("Playback resumed.")
                    }
                }
            } else {
                self.appRemote.playerAPI?.pause { _, error in
                    if let error = error {
                        print("Error pausing playback: \(error.localizedDescription)")
                    } else {
                        print("Playback paused.")
                    }
                }
            }
        }
    }
}


extension SpotifyService {
    
    func fetchArtwork(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let mimeType = httpResponse.mimeType, mimeType.hasPrefix("image"),
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "SpotifyServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response or data when fetching image"])))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
}
