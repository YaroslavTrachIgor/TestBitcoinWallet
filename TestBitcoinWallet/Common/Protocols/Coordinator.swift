//
//  Coordinator.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import UIKit

//MARK: - Main Coordinator protocol
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
