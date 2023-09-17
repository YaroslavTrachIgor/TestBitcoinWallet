//
//  SendCoordinator.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Main Coordinator
class SendCoordinator: Coordinator {
    var navigationController: UINavigationController
    var builder: SendBuilderProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.builder = SendBuilder(coordinator: self)
    }

    func start() {
        let viewController = builder?.showSendCryptoVC()
        navigationController.pushViewController(viewController!, animated: true)
    }
}
