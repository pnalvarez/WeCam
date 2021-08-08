//
//  UIStackView+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
