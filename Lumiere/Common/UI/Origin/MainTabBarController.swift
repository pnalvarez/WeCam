//
//  MainTabBarController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/09/21.
//  Copyright © 2021 WeCam. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            print("Tapped Create Project")
        }
    }
}

