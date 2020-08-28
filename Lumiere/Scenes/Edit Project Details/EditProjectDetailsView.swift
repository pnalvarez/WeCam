//
//  EditProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class EditProjectDetailsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var inviteFriendsButton: UIButton
    private unowned var backButton: DefaultBackButton
    private unowned var projectTitleTextField: UITextField
    private unowned var sinopsisTextView: UITextView
    private unowned var needTextView: UITextView
    private unowned var publishButton: UIButton
    private unowned var loadingView: LoadingView
    
    private lazy var projectTitleFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.projectTitleLbl
        view.textColor = EditProjectDetails.Constants.Colors.projectTitleFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.projectTitleLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var teamFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.teamFixedLbl
        view.textColor = EditProjectDetails.Constants.Colors.teamFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.teamFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var invitationsScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.showsHorizontalScrollIndicator = true
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = false
        view.isScrollEnabled = true
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var invitedFriendsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var sinopsisFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.sinopsisFixedLbl
        view.textColor = EditProjectDetails.Constants.Colors.sinopsisFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.sinopsisFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var needLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = EditProjectDetails.Constants.Colors.needLbl
        view.text = EditProjectDetails.Constants.Texts.needLbl
        view.font = EditProjectDetails.Constants.Fonts.needLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var invitationViews: [UserDisplayView] = .empty
    
    private var viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers? {
        didSet {
            viewModel?.users.forEach({
                let invitationView = UserDisplayView(frame: .zero,
                                                     name: $0.name,
                                                     ocupation: $0.ocupation,
                                                     photo: $0.image)
                invitationViews.append(invitationView)
                invitedFriendsContainer.addSubview(invitationView)
            })
        }
    }
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         inviteFriendsButton: UIButton,
         backButton: DefaultBackButton,
         projectTitleTextField: UITextField,
         sinopsisTextView: UITextView,
         needTextView: UITextView,
         publishButton: UIButton,
         loadingView: LoadingView) {
        self.activityView = activityView
        self.inviteFriendsButton = inviteFriendsButton
        self.backButton = backButton
        self.projectTitleTextField = projectTitleTextField
        self.sinopsisTextView = sinopsisTextView
        self.needTextView = needTextView
        self.publishButton = publishButton
        self.loadingView = loadingView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers) {
        self.viewModel = viewModel
        buildCarroussel()
        applyViewCode()
    }
    
    func flushCarrousel() {
        for view in invitationViews {
            view.removeFromSuperview()
        }
        invitationViews = .empty
    }
}

extension EditProjectDetailsView {
    
    private func buildCarroussel() {
        invitationsScrollView.contentSize = CGSize(width: (((invitationViews.count + 1) * 125) + (invitationViews.count - 1) * 8) / 2 + 50, height: 86)
        for index in 0..<invitationViews.count {
            invitationViews[index].snp.makeConstraints { make in
                make.height.equalTo(38)
                make.width.equalTo(125)
                if index == 0 { //First invite at the top left corner
                    make.top.equalToSuperview().inset(1)
                    make.left.equalToSuperview().offset(42).priority(250)
                } else if index == 1{ //Second invite at the bottom left corner
                    make.top.equalTo(invitationViews[0].snp.bottom).offset(10)
                    make.left.equalToSuperview().offset(42).priority(250)
                } else if index % 2 == 0 { //Even
                    make.top.equalToSuperview().inset(1)
                    make.left.equalTo(invitationViews[index-2].snp.right).offset(8).priority(250)
                } else { //Odd
                    make.top.equalTo(invitationViews[index-1].snp.bottom).offset(10)
                    make.left.equalTo(invitationViews[index-2].snp.right).offset(8).priority(250)
                }
            }
        }
    }
}

extension EditProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(projectTitleFixedLbl)
        addSubview(projectTitleTextField)
        addSubview(teamFixedLbl)
        invitationsScrollView.addSubview(invitedFriendsContainer)
        addSubview(invitationsScrollView)
        addSubview(inviteFriendsButton)
        addSubview(sinopsisFixedLbl)
        addSubview(sinopsisTextView)
        addSubview(needLbl)
        addSubview(needTextView)
        addSubview(publishButton)
        addSubview(loadingView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
            make.height.width.equalTo(31)
        }
        projectTitleFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(1)
            make.left.equalTo(backButton.snp.right).offset(8)
            make.width.equalTo(200)
        }
        projectTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(projectTitleFixedLbl)
            make.right.equalToSuperview().inset(48)
        }
        sinopsisFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(projectTitleTextField.snp.bottom).offset(20)
            make.left.equalTo(teamFixedLbl)
            make.right.equalToSuperview().inset(66)
        }
        sinopsisTextView.snp.makeConstraints { make in
            make.top.equalTo(sinopsisFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(sinopsisFixedLbl)
            make.right.equalToSuperview().inset(48)
            make.height.equalTo(150)
        }
        needLbl.snp.makeConstraints { make in
            make.top.equalTo(sinopsisTextView.snp.bottom).offset(20)
            make.left.equalTo(sinopsisTextView)
            make.width.equalTo(100)
        }
        needTextView.snp.makeConstraints { make in
            make.top.equalTo(needLbl.snp.bottom)
            make.left.equalTo(needLbl)
            make.right.equalToSuperview().inset(48)
            make.height.equalTo(59)
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(needTextView.snp.bottom).offset(20)
            make.left.equalTo(backButton.snp.right).offset(8)
            make.width.equalTo(70)
        }
        invitationsScrollView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(86)
        }
        activityView.snp.makeConstraints { make in
            make.top.equalTo(invitationsScrollView)
            make.bottom.equalTo(invitationsScrollView)
            make.right.left.equalToSuperview()
        }
        invitedFriendsContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
        inviteFriendsButton.snp.makeConstraints { make in
            make.top.equalTo(invitationsScrollView.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        publishButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
