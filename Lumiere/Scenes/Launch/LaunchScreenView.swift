//
//  LuanchScreenVW.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SnapKit

class LaunchScreenView: UIView {
    
    private unowned var iconView: UIImageView
    
    init(frame: CGRect,
         iconView: UIImageView) {
        self.iconView = iconView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could not load view")
    }
}

extension LaunchScreenView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(iconView)
    }
    
    func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.height.equalTo(123)
            make.width.equalTo(104)
            make.center.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = UIColor(rgb: 0xffffff)
        isUserInteractionEnabled = false
    }
}
