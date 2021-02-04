//
//  DefaultInputTextField.swift
//  WeCam
//
//  Created by Pedro Alvarez on 03/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

enum DefaultInputTextFieldState {
    case normal
    case error
}

class DefaultInputTextField: UITextField {
    
    var textFieldState: DefaultInputTextFieldState = .normal {
        didSet {
            switch textFieldState {
            case .normal:
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
            case .error:
                layer.borderWidth = 1
                layer.borderColor = ThemeColors.alertRed.rawValue.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColors.backgroundGray.rawValue
        font = ThemeFonts.RobotoRegular(12).rawValue
        autocapitalizationType = .none
        textColor = ThemeColors.normalText.rawValue
        autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
