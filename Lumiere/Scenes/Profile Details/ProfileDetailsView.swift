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
    private unowned var confirmationAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
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
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.contentSize = CGSize(width: frame.width, height: 200)
        return view
    }()
    
    private lazy var mainContainer: WCContentView = {
        let view = WCContentView(frame: .zero)
        view.style = .white
        return view
    }()
    
    private var viewModel: ProfileDetails.Info.ViewModel.User?
    
    init(frame: CGRect,
         ongoingProjectsCollectionView: UICollectionView,
         finishedProjectsCollectionView: UICollectionView,
         confirmationAlertView: ConfirmationAlertView,
         translucentView: UIView,
         profileHeaderView: WCProfileHeaderView) {
        self.ongoingProjectsCollectionView = ongoingProjectsCollectionView
        self.finishedProjectsCollectionView = finishedProjectsCollectionView
        self.confirmationAlertView = confirmationAlertView
        self.translucentView = translucentView
        self.profileHeaderView = profileHeaderView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ProfileDetails.Info.ViewModel.User) {
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func displayConfirmationView(withText text: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.confirmationAlertView.setupText(text)
            self.translucentView.isHidden = false
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.size.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = true
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.bottom)
                make.size.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
}

extension ProfileDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(profileHeaderView)
        mainContainer.addSubview(onGoingProjectsLbl)
        mainContainer.addSubview(ongoingProjectsCollectionView)
        mainContainer.addSubview(finishedProjectsCollectionView)
        mainContainer.addSubview(finishedProjectsLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(translucentView)
        addSubview(confirmationAlertView)
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
        confirmationAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
        translucentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        profileHeaderView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
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
        }
    }
    
    func configureViews() {
        scrollView.contentSize = CGSize(width: frame.width, height: 760)
        backgroundColor = .white
    }
}
