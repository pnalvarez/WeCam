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
    func defaultSubviewLoading(_ hide: Bool, forIdentifier identifier: String)
    func fullScreenLoading(_ hide: Bool)
    func showSuccessToast(withText text: String)
    func showErrorToast(withText text: String)
    func showAlertError(title: String, description: String, doneText: String)
    func showAlertSuccess(title: String, description: String, doneText: String)
}

extension ViewInterface {
    
    func defaultScreenLoading(_ hide: Bool) {
        DispatchQueue.main.async {
            if let mainView = self.view as? BaseView {
                mainView.defaultScreenLoading(hide)
            }
        }
    }
    
    func defaultSubviewLoading(_ hide: Bool, forIdentifier identifier: String) {
        DispatchQueue.main.async {
            if let mainView = self.view as? BaseView {
                mainView.defaultSubviewLoading(hide, forIdentifier: identifier)
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
        DispatchQueue.main.async {
            if let view = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController?.view {
                WCToastView().show(withTitle: text,
                                   status: .success,
                                   in: view)
            }
        }
    }
    
    func showErrorToast(withText text: String) {
        DispatchQueue.main.async {
            WCToastView().show(withTitle: text,
                               status: .error,
                               in: self.view)
        }
    }
    
    func showAlertError(title: String = WCConstants.Strings.errorTitle, description: String, doneText: String = WCConstants.Strings.ok) {
        DispatchQueue.main.async {
            WCDialogView().show(dialogType: .errorNotification(doneText: doneText),
                                in: self,
                                title: title,
                                description: description)
        }
    }
    
    func showAlertSuccess(title: String, description: String, doneText: String = WCConstants.Strings.ok) {
        DispatchQueue.main.async {
            WCDialogView().show(dialogType: .successNotification(doneText: doneText),
                                in: self,
                                title: title,
                                description: description)
        }
    }
}
