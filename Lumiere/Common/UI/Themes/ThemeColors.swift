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
    case alertGray
    case backgroundGray
    case alertRed
    case normalText
    case black
    case dividerGray
    case connectedGreen
    case disconnectedRed
    
    var rawValue: UIColor {
        switch self {
        case .mainRedColor:
            return #colorLiteral(red: 0.8980392157, green: 0.04705882353, blue: 0.2352941176, alpha: 1)
        case .emptyRedColor:
            return #colorLiteral(red: 0.8980392157, green: 0.04705882353, blue: 0.2352941176, alpha: 0.6)
        case .whiteThemeColor:
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .alertGray:
            return #colorLiteral(red: 0.5882352941, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        case .backgroundGray:
            return #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        case .alertRed:
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .normalText:
            return #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        case .black:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .dividerGray:
            return #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        case .connectedGreen:
            return #colorLiteral(red: 0.1764705882, green: 0.5176470588, blue: 0, alpha: 1)
        case .disconnectedRed:
            return #colorLiteral(red: 0.5058823529, green: 0, blue: 0, alpha: 1)
        }
    }
}
