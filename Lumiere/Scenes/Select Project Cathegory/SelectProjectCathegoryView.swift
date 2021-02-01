//
//  SelectProjectCathegoryView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SelectProjectCathegoryView: UIView {
    
    private unowned var closeButton: DefaultCloseButton
    private unowned var advanceButton: UIButton
    private unowned var collectionView: UICollectionView
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.contentSize = CGSize(width: view.frame.width, height: 1000)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = SelectProjectCathegory.Constants.Colors.titleLbl
        view.font = SelectProjectCathegory.Constants.Fonts.titleLbl
        view.text = SelectProjectCathegory.Constants.Texts.titleLbl
        return view
    }()
    
    init(frame: CGRect,
         closeButton: DefaultCloseButton,
         advanceButton: UIButton,
         collectionView: UICollectionView) {
        self.closeButton = closeButton
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
        mainContainer.addSubview(closeButton)
        mainContainer.addSubview(advanceButton)
        mainContainer.addSubview(collectionView)
        mainContainer.addSubview(titleLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
            make.height.equalTo(31)
            make.width.equalTo(31)
        }
        advanceButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.right.equalToSuperview().inset(28)
            make.height.equalTo(19)
            make.width.equalTo(59)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(advanceButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(87)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(121)
            make.left.right.equalToSuperview()
            make.height.equalTo(479)
            make.bottom.equalToSuperview().inset(71)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
