//
//  MovieStyleView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class WCMovieStyleButton: UIButton {
    
    private let disableColor = UIColor(rgb: 0xe50c3c)
    private let enableColor = UIColor(rgb: 0xe50c3c)
    private let textColor =  UIColor(rgb: 0xffffff)
    
    private var movieStyle: String?
    
    private(set) var isOn: Bool = false {
        didSet {
            if isOn {
                enableButton()
            } else {
                disableButton()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swap() {
        isOn = !isOn
    }
    
    func setupStyle(style: String) {
        self.movieStyle = style
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 4
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = textColor
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        titleLabel?.text = movieStyle
        disableButton()
    }
    
    private func enableButton() {
        backgroundColor = enableColor
    }
    
    private func disableButton() {
        backgroundColor = disableColor
    }
}

