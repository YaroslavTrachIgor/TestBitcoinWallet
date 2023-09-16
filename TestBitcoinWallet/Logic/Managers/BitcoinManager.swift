//
//  BitcoinManager.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-15.
//

import Foundation
import BitcoinKit
import BitcoinCore
import HdWalletKit





class BitcoinManager {
    
    let bitcoinKit: BitcoinKit.Kit
    
    init(kit: BitcoinKit.Kit) {
        bitcoinKit = kit
        bitcoinKit.delegate = self
    }
    
}


extension BitcoinManager: BitcoinCoreDelegate {
    
    func transactionsUpdated(inserted: [TransactionInfo], updated: [TransactionInfo]) {
        
    }
    
    func transactionsDeleted(hashes: [String]) {
        
    }
    
    private func balanceUpdated(balance: Int) {
        
    }
    
    func lastBlockInfoUpdated(lastBlockInfo: BlockInfo) {
        
    }
    
    public func kitStateUpdated(state: BitcoinCore.KitState) {
        
    }
    
}
