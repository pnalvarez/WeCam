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
    case emptyRedColor
    case whiteThemeColor
    
    var rawValue: UIColor {
        switch self {
        case .mainRedColor:
            return UIColor(rgb: 0xe50c3c)
        case .emptyRedColor:
            return UIColor(rgb: 0xe50c3c).withAlphaComponent(0.6)
        case .whiteThemeColor:
            return UIColor(rgb: 0xffffff)
        }
    }
}
