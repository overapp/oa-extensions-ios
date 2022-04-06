//
//  UIStoryboard+Extension.swift
//  OVS
//
//  Created by Osvaldo Pirrello on 02/02/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiate<T: UIViewController>() -> T? {
        // Get class name
        let className = String(describing: T.self)
        // Instantiate view controller
        return instantiateViewController(withIdentifier: className) as? T
    }

}
