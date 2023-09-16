//
//  SceneDelegate.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let rootViewController: UIViewController!
        if Manager.shared.savedRestoreData == nil {
            let setupWalletVC = SetupWalletViewController(nibName: "SetupWalletViewController", bundle: nil)
            let presenter = SetupWalletPresenter(view: setupWalletVC)
            setupWalletVC.presenter = presenter
            rootViewController = setupWalletVC
        } else {
            let tabBarController = UITabBarController()
            let router = MainRouter(tabBarController: tabBarController)
            router.start()
            rootViewController = tabBarController
        }
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

