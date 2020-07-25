//
//  ThemeColors.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 25/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

enum ThemeColors {
    case mainRedColor
    
    var rawValue: UIColor {
        switch self {
        case .mainRedColor:
            return UIColor(rgb: 0xe50c3c)
        }
    }
}
