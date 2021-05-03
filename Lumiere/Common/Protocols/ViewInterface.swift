//
//  ViewInterface.swift
//  WeCam
//
//  Created by Pedro Alvarez on 02/05/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ViewInterface where Self: UIViewController {
    func defaultScreenLoading(_ hide: Bool)
    func fullScreenLoading(_ hide: Bool)
}

extension ViewInterface {
    
    func defaultScreenLoading(_ hide: Bool) {
        if let mainView = view as? BaseView {
            mainView.defaultScreenLoading(hide)
        }
    }
    
    func fullScreenLoading(_ hide: Bool) {
        if let mainView = view as? BaseView {
            mainView.fullScreenLoading(hide)
        }
    }
}
