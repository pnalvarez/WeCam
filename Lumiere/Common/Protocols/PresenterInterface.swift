//
//  PresenterInterface.swift
//  WeCam
//
//  Created by Pedro Alvarez on 24/06/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

@objc protocol PresenterInterface {
    @objc optional func showAlertError(_ response: String)
    @objc optional func showToastError(_ response: String)
}
