//
//  SelectProjectImageView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SelectProjectImageView: UIView {
    
    private unowned var advanceButton: UIButton
    private unowned var selectedImageButton: UIButton
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = SelectProjectImage.Constants.Texts.titleLbl
        view.font = SelectProjectImage.Constants.Fonts.titleLbl
        view.textColor = SelectProjectImage.Constants.Colors.titleLbl
        view.textAlignment = .center
        return view
    }()
    
    init(frame: CGRect,
         advanceButton: UIButton,
         selectedImageView: UIButton) {
        self.advanceButton = advanceButton
        self.selectedImageButton = selectedImageView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectProjectImageView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(advanceButton)
        addSubview(selectedImageButton)
        addSubview(titleLbl)
    }
    
    func setupConstraints() {
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.right.equalToSuperview().inset(28)
            make.height.equalTo(19)
            make.width.equalTo(59)
        }
        selectedImageButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(142)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(selectedImageButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
