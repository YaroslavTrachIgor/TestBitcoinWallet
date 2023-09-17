//
//  MenuTabBarController.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Main Coordinator
class BalanceCoordinator: Coordinator {
    var navigationController: UINavigationController
    var builder: BalanceBuilderProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.builder = BalanceBuilder(coordinator: self)
    }

    func start() {
        let viewController = builder?.showWalletBalanceVC()
        navigationController.pushViewController(viewController!, animated: true)
    }
}
