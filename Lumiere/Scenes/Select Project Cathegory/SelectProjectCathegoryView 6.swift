//
//  SelectProjectCathegoryView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SelectProjectCathegoryView: UIView {
    
    private unowned var backButton: UIButton
    private unowned var advanceButton: UIButton
    private unowned var collectionView: UICollectionView
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = SelectProjectCathegory.Constants.Colors.titleLbl
        view.font = SelectProjectCathegory.Constants.Fonts.titleLbl
        view.text = SelectProjectCathegory.Constants.Texts.titleLbl
        return view
    }()
    
    init(frame: CGRect,
         backButton: UIButton,
         advanceButton: UIButton,
         collectionView: UICollectionView) {
        self.backButton = backButton
        self.advanceButton = advanceButton
        self.collectionView = collectionView
        super.init(frame: frame)
        applyViewCode()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectProjectCathegoryView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(advanceButton)
        addSubview(collectionView)
        addSubview(titleLbl)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
            make.height.equalTo(31)
            make.width.equalTo(31)
        }
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.right.equalToSuperview().inset(28)
            make.height.equalTo(19)
            make.width.equalTo(59)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(44)
            make.centerX.equalToSuperview()
            make.width.equalTo(87)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(58)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
