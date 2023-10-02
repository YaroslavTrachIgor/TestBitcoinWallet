//
//  MainRouter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Main Coordinator
final class MainRouter {
    var navigationController: UINavigationController
    
    //MARK: Private
    var cryptoCoinsMenuFlowRouter: CryptoCoinsMenuCoordinator?
    var receiveFlowRouter: ReceiveCoordinator?
    var balanceFlowRouter: BalanceCoordinator?
    var sendFlowRouter: SendCoordinator?
    
    
    //MARK: Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
}


//MARK: - Main Coordinator protocol extension
extension MainRouter: Coordinator, BitcoinManagerJnector {
    
    //MARK: Internal
    internal func start() {
        if (bitcoinManager?.isWalletCreated())! {
            presentMainMenuModule()
        } else {
            presentSetupWalletModule()
        }
    }
}


//MARK: - Main methods
private extension MainRouter {
    
    //MARK: Private
    func presentMainMenuModule() {
        setupCryptoCoinsMenuCoordinator()
        setupBalanceCoordinator()
        setupReceiveCoordinator()
        setupSendCoordinator()
        
        let tabBarController = UITabBarController()
        let coinsListNavigationController = cryptoCoinsMenuFlowRouter?.navigationController
        let balanceNavigationController = balanceFlowRouter?.navigationController
        let recieveNavigationController = receiveFlowRouter?.navigationController
        let sendNavigationController = sendFlowRouter?.navigationController
        let viewControllers = [coinsListNavigationController!,
                               balanceNavigationController!,
                               recieveNavigationController!,
                               sendNavigationController!]
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .link
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func presentSetupWalletModule() {
        let viewController = SetupWalletViewController()
        let loginService = LoginService()
        let presenter = SetupWalletPresenter(view: viewController, delegate: self, loginService: loginService)
        viewController.presenter = presenter
        navigationController.viewControllers = [viewController]
    }
    
    func setupCryptoCoinsMenuCoordinator() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.tabBarItem.title = "Coins"
        navigationController.tabBarItem.image = UIImage(systemName: "slider.horizontal.3")
        
        let coordinator = CryptoCoinsMenuCoordinator(navigationController: navigationController)
        cryptoCoinsMenuFlowRouter = coordinator
        cryptoCoinsMenuFlowRouter?.start()
    }
    
    func setupBalanceCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Balance"
        navigationController.tabBarItem.image = UIImage(systemName: "bitcoinsign")
        
        let coordinator = BalanceCoordinator(navigationController: navigationController)
        balanceFlowRouter = coordinator
        balanceFlowRouter?.start()
    }
    
    func setupSendCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Send"
        navigationController.tabBarItem.image = UIImage(systemName: "arrow.up.right")
        
        let coordinator = SendCoordinator(navigationController: navigationController)
        sendFlowRouter = coordinator
        sendFlowRouter?.start()
    }
    
    func setupReceiveCoordinator() {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Address"
        navigationController.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        let coordinator = ReceiveCoordinator(navigationController: navigationController)
        receiveFlowRouter = coordinator
        receiveFlowRouter?.start()
    }
}


//MARK: - Setup Wallet delegate protocol extension
extension MainRouter: SetupWalletPresenterCoordinatorDelegate {
    
    //MARK: Internal
    func presenter(_ presenter: SetupWalletPresenterProtocol) {
        presentMainMenuModule()
    }
}
