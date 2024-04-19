import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var rootViewController = ConnectLandingViewController() // This is your primary view controller.

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Setup the window and root view controller.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // Initialize the UINavigationController with rootViewController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window!.rootViewController = navigationController // Set the navigation controller as the rootViewController
        window!.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Code to handle app becoming active
        if let accessToken = SpotifyService.shared.appRemote.connectionParameters.accessToken {
            SpotifyService.shared.appRemote.connectionParameters.accessToken = accessToken
            SpotifyService.shared.appRemote.connect()
        } else if let accessToken = SpotifyService.shared.accessToken {
            SpotifyService.shared.appRemote.connectionParameters.accessToken = accessToken
            SpotifyService.shared.appRemote.connect()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Code to handle app becoming inactive
        if SpotifyService.shared.appRemote.isConnected {
            SpotifyService.shared.appRemote.disconnect()
        }
    }
    
    // Handle URL open contexts for authorization and authentication flows
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        let parameters = SpotifyService.shared.appRemote.authorizationParameters(from: url)
        if let code = parameters?["code"] {
            SpotifyService.shared.responseCode = code
        } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            SpotifyService.shared.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("No access token error =", error_description)
        }
    }
}
