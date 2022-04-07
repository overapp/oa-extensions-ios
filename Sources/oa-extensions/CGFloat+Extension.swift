//
//  CGFloat+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}
