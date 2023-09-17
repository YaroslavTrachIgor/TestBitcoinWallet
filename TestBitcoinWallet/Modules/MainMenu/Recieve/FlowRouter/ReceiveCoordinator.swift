//
//  ReceiveCoordinator.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Main Coordinator
class ReceiveCoordinator: Coordinator {
    var navigationController: UINavigationController
    var builder: RecieveBuilderProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.builder = RecieveBuilder(coordinator: self)
    }

    func start() {
        let viewController = builder?.showRecieveCryptoVC()
        navigationController.pushViewController(viewController!, animated: true)
    }
}
