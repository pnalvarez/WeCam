//
//  DefaultBackButton.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class DefaultBackButton: UIButton {
    
    weak var associatedViewController: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "voltar 1",
                         in: ProjectProgress.bundle,
                         compatibleWith: nil),
                 for: .normal)
        addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func backAction() {
        associatedViewController?.navigationController?.popViewController(animated: true)
    }
}
