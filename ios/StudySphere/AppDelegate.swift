//
//  AppDelegate.swift
//  StudyTogether
//
//  Created by Team 24 on 4/9/23.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ParseSwift.initialize(applicationId: "940ZllFVRMXvnoPnbM4PJ0yeIIfBcJQYUAVJNX24",
                              clientKey: "egUjvaeTuehe1KGy2fgFnd1xfLdL0SjZG4Zytol1",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
