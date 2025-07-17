//
//  AppDelegate.swift
//  WeatherTask
//
//  Created by RajNandini on 15/07/25.
//

import UIKit
import Toast
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupNetworkReachability()
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



extension AppDelegate{
    
    func setupNetworkReachability(){
        
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("No internet connection.")
                UIApplication.topViewController()?.view.makeToast("You're offline. Please check your internet connection.")
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                print("Connected to internet.")
                UIApplication.topViewController()?.view.makeToast("You're now connected.")
            case .unknown:
                print("Network status is unknown.")
                UIApplication.topViewController()?.view.makeToast("You're now connected.")

            }
        })
        
    }
}



extension UIApplication {
    class func topViewController(base: UIViewController? = {
        // Get the key window's root view controller
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        }
        return nil
    }()) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}




