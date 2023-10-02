//
//  CryptoCoinsMenuCoordinator.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import Foundation
import UIKit

//MARK: - Main Coordinator
class CryptoCoinsMenuCoordinator: Coordinator {
    var navigationController: UINavigationController
    var builder: CryptoCoinsMenuBuilderProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.builder = CryptoCoinsMenuBuilder(coordinator: self)
    }

    func start() {
        let viewController = builder?.showCryptoCoinsMenuVC()
        navigationController.pushViewController(viewController!, animated: true)
    }
}
