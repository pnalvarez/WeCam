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
    
    private enum Constants {
        static let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
    
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
        tintColor = ThemeColors.mainRedColor.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
}
