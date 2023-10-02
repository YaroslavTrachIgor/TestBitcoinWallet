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


//MARK: - Fast Double functions
public extension Double {
    
    //MARK: Public
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
