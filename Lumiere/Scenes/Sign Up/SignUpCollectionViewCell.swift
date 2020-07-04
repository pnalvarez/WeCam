//
//  SignUpCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SignUpCollectionViewCellDelegate: class {
    func didSelectButton(withStyle style: MovieStyle)
    func didUnselectButton(withStyle style: MovieStyle)
}

class SignUpCollectionViewCell: UICollectionViewCell {
    
    private lazy var movieStyleButton: MovieStyleButton = {
        let button = MovieStyleButton(frame: .zero,
                                      movieStyle: movieStyle?.rawValue ?? .empty)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpOutside)
        return button
    }()
    
    private var movieStyle: MovieStyle?
    
    private weak var delegate: SignUpCollectionViewCellDelegate?
    
    private func setup(movieStyle: MovieStyle) {
        self.movieStyle = movieStyle
        applyViewCode()
    }
}

extension SignUpCollectionViewCell {
    
    @objc
    private func didTapButton() {
        guard let style = movieStyle else { return }
        if movieStyleButton.isOn {
            delegate?.didUnselectButton(withStyle: style)
        } else {
            delegate?.didSelectButton(withStyle: style)
        }
        movieStyleButton.swap()
    }
}

extension SignUpCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(movieStyleButton)
    }
    
    func setupConstraints() {
        movieStyleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(87)
            make.width.equalTo(99)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
