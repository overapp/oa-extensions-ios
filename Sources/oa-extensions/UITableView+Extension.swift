//
//  UITableView+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ type: T.Type) {
        // Get class name
        let className = String(describing: T.self)
        // Register
        register(type, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        // Get class name
        let className = String(describing: T.self)
        // Register header view
        register(T.self, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerNib<T: UITableViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        // Get class name
        let className = String(describing: T.self)
        // Get NIB
        let nib = UINib(nibName: className, bundle: bundle)
        // Register NIB
        register(nib, forCellReuseIdentifier: className)
    }

    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        // Get class name
        let className = String(describing: T.self)
        // Guard dequeued cell
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            // Print
            print("🤬 The dequeued cell is not an instance of \(className).")
            // Return a default instance for cell
            return T(style: .default, reuseIdentifier: className)
        }
        // Return dequeued cell
        return cell
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        // Get class name
        let className = String(describing: T.self)
        // Guard dequeued cell
        guard let headerView = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            // Print
            print("🤬 The dequeued header view is not an instance of \(className).")
            // Return a default instance for cell
            return T()
        }
        // Return dequeued cell
        return headerView
    }
    
}
