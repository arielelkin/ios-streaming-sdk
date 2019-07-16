//
//  Spotify .swift
//
//  Created by Ariel Elkin on 10/07/2019.
//

import UIKit

class Spotify: NSObject {

    static let shared: Spotify = {

        let instance = Spotify()

        if let persistedSession = persistedSession {
            SPTAuth.defaultInstance().session = persistedSession
        }

        let player = SPTAudioStreamingController.sharedInstance()
        player.delegate = instance

        return instance
    }()

    private static var persistedSession: SPTSession? {
        if let persistedSessionData = UserDefaults.standard.value(forKey: sessionUserDefaultsKey) as? Data,
            let persistedSession = try? NSKeyedUnarchiver.unarchivedObject(
                ofClass: SPTSession.self,
                from: persistedSessionData) {
            return persistedSession
        }
        return nil
    }

    var isLoggedIn: Bool {
        if let session = SPTAuth.defaultInstance().session, session.isValid() {
            return true
        } else {
            return false
        }
    }
}
