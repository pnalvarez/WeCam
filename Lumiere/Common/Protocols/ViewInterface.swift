//
//  ViewInterface.swift
//  WeCam
//
//  Created by Pedro Alvarez on 02/05/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ViewInterface where Self: UIViewController {
    func defaultScreenLoading(_ hide: Bool)
    func fullScreenLoading(_ hide: Bool)
    func showSuccessToast(withText text: String)
    func showErrorToast(withText text: String)
}

extension ViewInterface {
    
    func defaultScreenLoading(_ hide: Bool) {
        DispatchQueue.main.async {
            if let mainView = self.view as? BaseView {
                mainView.defaultScreenLoading(hide)
            }
        }
    }
    
    func fullScreenLoading(_ hide: Bool) {
        DispatchQueue.main.async {
            if let mainView = self.view as? BaseView {
                mainView.fullScreenLoading(hide)
            }
        }
    }
    
    func showSuccessToast(withText text: String) {
        WCToastView().show(withTitle: text,
                           status: .success,
                           in: view)
    }
    
    func showErrorToast(withText text: String) {
        WCToastView().show(withTitle: text,
                           status: .error,
                           in: view)
    }
}
