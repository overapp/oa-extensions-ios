//
//  UIView+Extension.swift
//  OVS
//
//  Created by Osvaldo Pirrello on 02/02/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     *
     */
    class func fromNib<T: UIView>() -> T? {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as? T
    }
    
}
