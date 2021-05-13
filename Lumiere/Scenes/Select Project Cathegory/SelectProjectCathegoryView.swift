//
//  SelectProjectCathegoryView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SelectProjectCathegoryView: BaseView, ModalViewable {
    
    private unowned var advanceButton: WCActionButton
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
         advanceButton: WCActionButton,
         collectionView: UICollectionView) {
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
        mainContainer.addSubview(advanceButton)
        mainContainer.addSubview(collectionView)
        mainContainer.addSubview(titleLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(102)
            make.centerX.equalToSuperview()
            make.width.equalTo(82)
            make.bottom.equalToSuperview().inset(24)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(87)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(121)
            make.left.right.equalToSuperview()
            make.height.equalTo(479)
        }
    }
}
