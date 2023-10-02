//
//  SceneDelegate.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        let router = MainRouter(navigationController: navigationController)
        router.start()
        
        
//            
//        
//        let coinMarketManager = CoinMarketManager()
//        coinMarketManager.getCryptoCoins { result in
//            switch result {
//            case .success(let coins):
//                for coin in coins {
//                    print(coin.name)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//            
            
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
