//
//  ProfileDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit
import SDWebImage

class ProfileDetailsView: BaseView {
    
    private unowned var ongoingProjectsCollectionView: UICollectionView
    private unowned var finishedProjectsCollectionView: UICollectionView
    private unowned var profileHeaderView: WCProfileHeaderView
    
    private lazy var onGoingProjectsLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileDetails.Constants.Texts.onGoingProjectsLbl
        view.font = ProfileDetails.Constants.Fonts.onGoingProjectsLbl
        view.textColor = ProfileDetails.Constants.Colors.onGoingProjectsLbl
        return view
    }()
    
    private lazy var finishedProjectsLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileDetails.Constants.Texts.finishedProjectsLbl
        view.textColor = ProfileDetails.Constants.Colors.finishedProjectsLbl
        view.font = ProfileDetails.Constants.Fonts.finishedProjectsLbl
        return view
    }()
    
    private lazy var scrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()
    
    init(frame: CGRect,
         ongoingProjectsCollectionView: UICollectionView,
         finishedProjectsCollectionView: UICollectionView,
         profileHeaderView: WCProfileHeaderView) {
        self.ongoingProjectsCollectionView = ongoingProjectsCollectionView
        self.finishedProjectsCollectionView = finishedProjectsCollectionView
        self.profileHeaderView = profileHeaderView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        scrollView.addSubview(profileHeaderView)
        scrollView.addSubview(onGoingProjectsLbl)
        scrollView.addSubview(ongoingProjectsCollectionView)
        scrollView.addSubview(finishedProjectsCollectionView)
        scrollView.addSubview(finishedProjectsLbl)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(41)
            make.right.left.equalToSuperview()
        }
        onGoingProjectsLbl.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(46)
            make.left.equalToSuperview().inset(26)
            make.width.equalTo(208)
        }
        ongoingProjectsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(onGoingProjectsLbl.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
        finishedProjectsLbl.snp.makeConstraints { make in
            make.top.equalTo(ongoingProjectsCollectionView.snp.bottom).offset(57)
            make.left.width.equalTo(onGoingProjectsLbl)
        }
        finishedProjectsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(finishedProjectsLbl.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(182)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
