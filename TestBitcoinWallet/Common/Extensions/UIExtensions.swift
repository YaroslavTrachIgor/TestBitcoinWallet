//
//  UIExtensions.swift
//  TestBitcoinWallet
//
//  Created by User on 2023-10-02.
//

import Foundation
import UIKit

//MARK: - Fast hex Color transformation initialization
public extension UIColor {
    
    //MARK: Public
    /// In the code below, we create a special formatter that will allow us to convert hes code to UIColor.
    /// Some parameters(for instance, `scanLocation`) have been removed in new versions of iOS,
    /// so in the future you will need to find a replacement for them.
    ///
    /// This initialization will typically be used to format JSON content.
    /// - Parameters:
    ///   - hexString: hex color code.
    ///   - alpha: color opacity.
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let set              = CharacterSet.whitespacesAndNewlines
        let hexString        = hexString.trimmingCharacters(in: set)
        let scanner          = Scanner(string: hexString)
        var color: UInt32    = 0
        scanner.scanLocation = 1
        scanner.scanHexInt32(&color)
        let maxValue         = 255.0
        let mask             = 0x000000FF
        let rInt             = Int(color >> 16) & mask
        let gInt             = Int(color >> 8) & mask
        let bInt             = Int(color) & mask
        let red              = CGFloat(rInt) / maxValue
        let blue             = CGFloat(bInt) / maxValue
        let green            = CGFloat(gInt) / maxValue
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
