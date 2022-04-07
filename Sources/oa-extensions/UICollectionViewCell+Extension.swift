//
//  UICollectionViewCell+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 07/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        return self.next(of: UICollectionView.self)
    }

    var indexPath: IndexPath? {
        return self.collectionView?.indexPath(for: self)
    }
    
}
