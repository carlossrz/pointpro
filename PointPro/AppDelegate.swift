//
//  AppDelegate.swift
//  PointPro
//
//  Created by Carlos Suarez on 6/6/25.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        PhoneSessionManager.shared  // Activa WCSession al iniciar la app (WacthConectivity)
        return true
    }
}
