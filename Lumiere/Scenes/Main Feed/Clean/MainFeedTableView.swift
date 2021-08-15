//
//  MainFeedTableView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class MainFeedTableView: UITableView {

    override init(frame: CGRect,
         style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
        bounces = false
        alwaysBounceVertical = false
        backgroundColor = .white
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

