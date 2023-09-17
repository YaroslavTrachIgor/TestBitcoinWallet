//
//  FoundationExtensions.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-09-14.
//

import Foundation

//MARK: - Fast Decimal functions
public extension Decimal {
    
    //MARK: Public
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 8
        formatter.maximumFractionDigits = 8
        return formatter.string(from: self as NSDecimalNumber)!
    }
}
