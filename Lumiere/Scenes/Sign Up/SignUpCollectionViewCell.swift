//
//  SignUpCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SignUpCollectionViewCell: UICollectionViewCell {
    
    enum State {
        case enable
        case disable
    }
    
    private lazy var mainLbl: UILabel = { return UILabel(frame: .zero) }()
    
    private var movieStyle: MovieStyle?
    
    var state: State = .disable {
        didSet {
            switch state {
            case .enable:
                enableButton()
                break
            case .disable:
                disableButton()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        backgroundColor = SignUp.Constants.Colors.signUpButtonDeactivatedColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movieStyle: MovieStyle) {
        self.movieStyle = movieStyle
        applyViewCode()
    }
}

extension SignUpCollectionViewCell {
    
    private func enableButton() {
        backgroundColor = SignUp.Constants.Colors.signUpButtonBackgroundColor
    }
    
    private func disableButton() {
        backgroundColor = SignUp.Constants.Colors.signUpButtonDeactivatedColor
    }
}

extension SignUpCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(mainLbl)
    }
    
    func setupConstraints() {
        mainLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(5)
        }
    }
    
    func configureViews() {
        mainLbl.backgroundColor = .clear
        mainLbl.text = movieStyle?.rawValue
        mainLbl.textAlignment = .center
        mainLbl.numberOfLines = 1
        mainLbl.font = SignUp.Constants.Fonts.cathegoriesLblFont
        mainLbl.textColor = SignUp.Constants.Colors.signUpCollectionViewCellText
        mainLbl.adjustsFontSizeToFitWidth = true
        mainLbl.minimumScaleFactor = 0.5
    }
}
