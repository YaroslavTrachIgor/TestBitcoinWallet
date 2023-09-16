//
//  MainRouter.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Base Router protocol
protocol Router {
    var tabBarController: UITabBarController { get set }
    func start()
}


//MARK: - Main Coordinator
final class MainRouter: Router {
    var tabBarController: UITabBarController
    
    //MARK: Private
    var receiveFlowRouter: ReceiveCoordinator?
    var balanceFlowRouter: BalanceCoordinator?
    var sendFlowRouter: SendCoordinator?
    
    
    //MARK: Initialization
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        setupBalanceCoordinator()
        setupReceiveCoordinator()
        setupSendCoordinator()
        setupTabBar()
    }
}


//MARK: - Main Coordinator protocol extension
extension MainRouter {
    
    //MARK: Internal
    internal func start() {
        let balanceNavigationController = balanceFlowRouter?.navigationController
        let recieveNavigationController = receiveFlowRouter?.navigationController
        let sendNavigationController = sendFlowRouter?.navigationController
        let viewControllers = [balanceNavigationController!,
                               recieveNavigationController!,
                               sendNavigationController!]
        tabBarController.viewControllers = viewControllers
    }
}


//MARK: - Main methods
private extension MainRouter {
    
    //MARK: Private
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
    
    func setupTabBar() {
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .link
    }
}
