//
//  UICollectionView+Extension.swift
//  OVS
//
//  Created by Osvaldo Pirrello on 02/02/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        // Get class name
        let className = String(describing: type)
        // Register UICollectionViewCell
        register(type, forCellWithReuseIdentifier: className)
    }
    
    func registerSupplementary<T: UICollectionReusableView>(_ type: T.Type, kind: String) {
        // Get class name
        let className = String(describing: type)
        // Register supplementary View
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func registerNib<T: UICollectionViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        // Get class name
        let className = String(describing: T.self)
        // Get NIB
        let nib = UINib(nibName: className, bundle: bundle)
        // Register NIB
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func registerSupplementaryNib<T: UICollectionReusableView>(_ type: T.Type, kind: String, bundle: Bundle? = nil) {
        // Get class name
        let className = String(describing: type)
        // Get NIB
        let nib = UINib(nibName: className, bundle: bundle)
        // Register supplementary View
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        // Get class name
        let className = String(describing: T.self)
        // Guard dequeued cell
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            // Print
            print("🤬 The dequeued cell is not an instance of \(className).")
            // Fallback
            return T()
        }
        // Return dequeued cell
        return cell
    }
    
    func dequeueSupplementary<T: UICollectionReusableView>(_: T.Type, kind: String, for indexPath: IndexPath) -> T {
        // Get class name
        let className = String(describing: T.self)
        // Guard dequeued supplementary view
        guard let header = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: className,
                for: indexPath) as? T else {
            // Print
            print("🤬 The dequeued supplementary view is not an instance of \(className).")
            // Fallback
            return T()
        }
        // Return dequeued supplementary view
        return header
    }
    
}
