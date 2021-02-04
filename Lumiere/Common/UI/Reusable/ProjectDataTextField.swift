//
//  ProjectDataTextField.swift
//  WeCam
//
//  Created by Pedro Alvarez on 04/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

enum ProjectDataTextFieldState {
    case normal
    case error
}

class ProjectDataTextField: UITextField {
    
    var textFieldState: ProjectDataTextFieldState = .normal {
        didSet {
            switch textFieldState {
            case .normal:
                layer.borderColor = UIColor(rgb: 0xe0e0e0).cgColor
            case .error:
                layer.borderColor = ThemeColors.alertRed.rawValue.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColors.whiteThemeColor.rawValue
        textColor = .black
        font = ThemeFonts.RobotoRegular(16).rawValue
        layer.borderWidth = 1
        layer.cornerRadius = 4
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
