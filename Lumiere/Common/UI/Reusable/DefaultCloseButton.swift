//
//  DefaultCloseButton.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class DefaultCloseButton: UIButton {
    
    var associatedViewController: UIViewController?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setImage(UIImage(named: "fechar 1",
                         in: OnGoingProjectDetails.bundle,
                         compatibleWith: nil),
                 for: .normal)
        addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    @objc
    private func closeAction() {
        if let navigationController = associatedViewController?.navigationController {
            navigationController.dismiss(animated: true, completion: nil)
        } else {
            associatedViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
