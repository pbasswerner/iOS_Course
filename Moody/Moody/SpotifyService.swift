//
//  SpotifyService.swift
//  Moody
//
//  Created by Paula Basswerner on 4/16/24.
//

//import Foundation
//
//
//class SpotifyService {
//    var configuration: SPTConfiguration {
//        let config = SPTConfiguration(clientID: "your-client-id", redirectURL: URL(string: "your-redirect-uri")!)
//        config.playURI = ""
//        return config
//    }
//
//    lazy var sessionManager: SPTSessionManager = {
//        let manager = SPTSessionManager(configuration: configuration, delegate: self)
//        return manager
//    }()
//
//    func authorize() {
//        let requestedScopes: SPTScope = [.appRemoteControl, .streaming]
//        sessionManager.initiateSession(with: requestedScopes, options: .default)
//    }
//}
//
//extension SpotifyService: SPTSessionManagerDelegate {
//    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//        print("Authorization failed: \(error)")
//    }
//
//    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
//        print("Renewed: \(session)")
//    }
//
//    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
//        print("Session initiated: \(session)")
//    }
//}
