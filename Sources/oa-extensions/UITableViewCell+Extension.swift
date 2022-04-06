//
//  UITableViewCell+Extension.swift
//  Bikevo
//
//  Created by Osvaldo Pirrello on 04/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    var outerTableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.outerTableView?.indexPath(for: self)
    }
    
}
