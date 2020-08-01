//
//  AppDelegate.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase

var authListner : AuthStateDidChangeListenerHandle?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        

        Auth.auth().signInAnonymously { (result, error) in
        

            if error != nil {
                print(error!.localizedDescription)
                return
            }

            guard let user = result?.user else {return}
            let isAnonimous = user.isAnonymous

            let uid = user.uid

            UserDefaults.standard.setValue(uid, forKey: kCURRENTUID)
            UserDefaults.standard.synchronize()
            return
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

