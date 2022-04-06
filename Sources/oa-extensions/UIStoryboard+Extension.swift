//
//  UIStoryboard+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    
    func instantiate<T: UIViewController>() -> T? {
        // Get class name
        let className = String(describing: T.self)
        // Instantiate view controller
        return instantiateViewController(withIdentifier: className) as? T
    }

}
