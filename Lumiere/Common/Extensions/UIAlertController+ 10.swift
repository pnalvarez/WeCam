//
//  UIAlertController+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 15/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func displayAlert(in controller: UIViewController,
                             title: String,
                             message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertAction.setValue(ThemeColors.mainRedColor.rawValue, forKey: "titleTextColor")
        alertController.addAction(alertAction)

        controller.present(alertController, animated: true)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for i in self.actions {
            let attributedText = NSAttributedString(string: "OK",
                                                    attributes: [NSAttributedString.Key.font: ThemeFonts.RobotoBold(18).rawValue, NSAttributedString.Key.foregroundColor: ThemeColors.mainRedColor.rawValue])
            guard let label = (i.value(forKey: "__representer") as AnyObject).value(forKey: "label") as? UILabel else { return }
            label.attributedText = attributedText
        }

    }
}
