//
//  UIButton+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

/**
 https://stackoverflow.com/questions/17800288/autolayout-intrinsic-size-of-uibutton-does-not-include-title-insets
 */
public extension UIButton {
    
    override var intrinsicContentSize: CGSize {
        // Get instrinsic content size
        let intrinsicContentSize = super.intrinsicContentSize
        // Adjusted width and height
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        // Return adjusted
        return CGSize(width: adjustedWidth + 10, height: adjustedHeight)
    }
    
}
