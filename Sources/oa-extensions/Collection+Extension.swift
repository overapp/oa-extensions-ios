//
//  Collection+Extension.swift
//  Bikevo
//
//  Created by Osvaldo Pirrello on 16/12/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import Foundation

extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}

extension Collection where Element == Double {
    /// Returns the average of all elements in the array
    func average() -> Double { isEmpty ? 0.0 : sum() / Double(count) }
}

extension Collection where Element == Double {
    /// Returns the average of all elements in the array
    func averageNotZeros() -> Double {
        if isEmpty { return 0.0 }
        
        let valuesNotZeros = filter({ $0 > 0.0 })
        
        let sum = valuesNotZeros.sum()
        
        if sum == 0.0 {
            return 0.0
        }
        
        return sum / Double(valuesNotZeros.count)
    }
}
