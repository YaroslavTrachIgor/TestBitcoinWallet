//
//  TstWalletConfiguration.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import Foundation
import BitcoinCore
import HsToolKit
import HdWalletKit

class Configuration {
    static let shared = Configuration()

    let minLogLevel: Logger.Level = .verbose
    let testNet = true
    let purpose = Purpose.bip86
    let defaultWords = ["tree game apple harvest silly pink much lemon elegant illness edge silk"]
}
