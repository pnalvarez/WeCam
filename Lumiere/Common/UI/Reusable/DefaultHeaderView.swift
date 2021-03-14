//
//  DefaultHeaderView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

class DefaultHeaderView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "tipografia-projeto 2")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
