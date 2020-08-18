//
//  SelectProjectImageView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SelectProjectImageView: UIView {
    
    private unowned var backButton: UIButton
    private unowned var advanceButton: UIButton
    private unowned var imagesCollectionView: UICollectionView
    private unowned var selectedImageView: UIImageView
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = SelectProjectImage.Constants.Texts.titleLbl
        view.font = SelectProjectImage.Constants.Fonts.titleLbl
        view.textColor = SelectProjectImage.Constants.Colors.titleLbl
        view.textAlignment = .center
        return view
    }()
    
    init(frame: CGRect,
         backButton: UIButton,
         advanceButton: UIButton,
         imagesCollectionView: UICollectionView,
         selectedImageView: UIImageView) {
        self.backButton = backButton
        self.advanceButton = advanceButton
        self.imagesCollectionView = imagesCollectionView
        self.selectedImageView = selectedImageView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectProjectImageView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(advanceButton)
        addSubview(selectedImageView)
        addSubview(titleLbl)
        addSubview(imagesCollectionView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
            make.height.equalTo(32)
            make.width.equalTo(31)
        }
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.right.equalToSuperview().inset(28)
            make.height.equalTo(19)
            make.width.equalTo(59)
        }
        selectedImageView.snp.makeConstraints { make in
            make.top.equalTo(advanceButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(84)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(100)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
