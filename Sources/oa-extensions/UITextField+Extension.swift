//
//  UITextField+Extension.swift
//  Bikevo
//
//  Created by Osvaldo Pirrello on 26/03/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension UITextField {
    
    var hasPlaceholder: Bool {
        return placeholder?.isEmpty == false
    }
    
    func setCursorLocation(_ location: Int) {
        guard let cursorLocation = position(from: beginningOfDocument, offset: location) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
        }
    }
    
}
