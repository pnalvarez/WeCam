//
//  NestedNavigationController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 02/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

final class NestedNavigationController: UINavigationController {
    
    override func popViewController(animated: Bool) -> UIViewController? {
        self.dismiss(animated: false, completion: nil)
        return super.popViewController(animated: animated)
    }
}
