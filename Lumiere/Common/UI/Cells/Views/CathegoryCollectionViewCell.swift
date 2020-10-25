//
//  CathegoryCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class CathegoryCollectionViewCell: UICollectionViewCell {
    
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
        backgroundColor = UIColor(rgb: 0xe50c3c).withAlphaComponent(0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movieStyle: MovieStyle) {
        self.movieStyle = movieStyle
        applyViewCode()
    }
}

extension CathegoryCollectionViewCell {
    
    private func enableButton() {
        backgroundColor = UIColor(rgb: 0xe50c3c)
    }
    
    private func disableButton() {
        backgroundColor = UIColor(rgb: 0xe50c3c).withAlphaComponent(0.6)
    }
}

extension CathegoryCollectionViewCell: ViewCodeProtocol {
    
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
        mainLbl.text = movieStyle?.rawValue
        mainLbl.textAlignment = .center
        mainLbl.numberOfLines = 0
        mainLbl.font = ThemeFonts.RobotoBold(16).rawValue
        mainLbl.textColor = UIColor(rgb: 0xffffff)
    }
}
