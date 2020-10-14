//
//  UISegmentedControl+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    
    static func setupSegmentedControlUI() {
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SearchResults.Constants.Colors.resultTypeSegmentedControlText, NSAttributedString.Key.font: SearchResults.Constants.Fonts.resultTypeSegmentedControl], for: .normal)
    }
}
