//
//  UIView+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
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
