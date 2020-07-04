//
//  MovieStyleView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MovieStyleButtonDelegate: class {
    func didTap(withStyle style: String)
}

class MovieStyleButton: UIButton {
    
    private let disableColor = UIColor(rgb: 0xe50c3c)
    private let enableColor = UIColor(rgb: 0xe50c3c)
    private let textColor =  UIColor(rgb: 0xffffff)
    
    private var movieStyle: String
    
    private weak var delegate: MovieStyleButtonDelegate?
    
    private(set) var isOn: Bool = false {
        didSet {
            if isOn {
                enableButton()
            } else {
                disableButton()
            }
        }
    }
    
    init(frame: CGRect,
         movieStyle: String,
         delegate: MovieStyleButtonDelegate? = nil) {
        self.movieStyle = movieStyle
        self.delegate = delegate
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 4
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = textColor
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
        disableButton()
    }
    
    private func enableButton() {
        backgroundColor = enableColor
    }
    
    private func disableButton() {
        backgroundColor = disableColor
    }
}

extension MovieStyleButton {
    
    @objc
    private func didTap() {
        isOn = !isOn
        delegate?.didTap(withStyle: movieStyle)
    }
}
