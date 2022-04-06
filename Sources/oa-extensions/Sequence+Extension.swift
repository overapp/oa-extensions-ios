//
//  Sequence+Extension.swift
//  Bikevo
//
//  Created by Osvaldo Pirrello on 16/12/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}
