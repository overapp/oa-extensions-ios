//
//  UIViewController+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    // MARK: - Helpers
    
    /**
     Delay
     */
    func delay(_ dispatchTime: DispatchTime, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    func instantiate<T: UIViewController>(_: T.Type) -> T {
        // Get view controller from storyboard
        guard let viewController: T = storyboard?.instantiate() else {
            // print
            print("🤬 Cannot instantiate \(String(describing: T.self)).")
            // Fallback
            return T()
        }
        // Return viewController
        return viewController
    }
    
}
