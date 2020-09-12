//
//  UIView+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
