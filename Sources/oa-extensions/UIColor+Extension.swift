//
//  UIColor+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import UIKit

public extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue  & 0x0000FF) / 255.0,
            alpha: alpha)
    }
    
    var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return "#000000"
        }
        
        func round(_ value: CGFloat) -> Int {
            lround(Double(value) * 255)
        }
        
        if alpha == 1 {
            return String(format: "#%02lX%02lX%02lX", round(red), round(green), round(blue))
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX", round(red), round(green), round(blue), round(alpha))
        }
    }
    
    // MARK: - Methods
    
    static func blend(from fromColor: UIColor, to toColor: UIColor, by percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 1.0), 0) / 1.0
        switch percentage {
        case 0: return fromColor
        case 1: return toColor
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard fromColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return fromColor }
            guard toColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return toColor }
            
            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return adjust(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return adjust(by: -1 * abs(percentage))
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return self
        }
    }
    
}
