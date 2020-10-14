//
//  OptionFilterButton.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class OptionFilterButton: UIButton {
    
    init(frame: CGRect,
         option: String) {
        super.init(frame: frame)
        setTitle(option, for: .normal)
        setTitleColor(UIColor(rgb: 0x969494), for: .normal)
        titleLabel?.font = ThemeFonts.RobotoBold(12).rawValue
        titleLabel?.textAlignment = .left
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(rgb: 0xe3e0e0).cgColor
        contentHorizontalAlignment = .leading
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
