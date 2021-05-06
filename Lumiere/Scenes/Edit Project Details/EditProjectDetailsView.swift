//
//  EditProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class EditProjectDetailsView: BaseView, ModalViewable {
    
    private unowned var inviteFriendsButton: UIButton
    private unowned var projectTitleTextField: WCProjectDataTextField
    private unowned var sinopsisTextView: WCProjectDataTextView
    private unowned var needTextView: WCProjectDataTextView
    private unowned var publishButton: UIButton
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = true
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
//        view.contentSize = CGSize(width: view.frame.width, height: 900)
        return view
    }()
    
    private lazy var mainContainer: WCContentView = {
        let view = WCContentView(frame: .zero)
        view.style = .white
        return view
    }()
    
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
        view.textAlignment = .left
        return view
    }()
    
    private lazy var invitationViews: [WCUserDisplayView] = .empty
    
    private var viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers? {
        didSet {
            viewModel?.users.forEach({
                let invitationView = WCUserDisplayView(frame: .zero,
                                                     name: $0.name,
                                                     ocupation: $0.ocupation,
                                                     photo: $0.image)
                invitationViews.append(invitationView)
                invitedFriendsContainer.addSubview(invitationView)
            })
        }
    }
    
    init(frame: CGRect,
         inviteFriendsButton: UIButton,
         projectTitleTextField: WCProjectDataTextField,
         sinopsisTextView: WCProjectDataTextView,
         needTextView: WCProjectDataTextView,
         publishButton: UIButton) {
        self.inviteFriendsButton = inviteFriendsButton
        self.projectTitleTextField = projectTitleTextField
        self.sinopsisTextView = sinopsisTextView
        self.needTextView = needTextView
        self.publishButton = publishButton
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
    
    func cleanTextFields() {
        sinopsisTextView.textViewState = .normal
        projectTitleTextField.textFieldState = .normal
    }
    
    func updateForFinishedProject() {
        needLbl.isHidden = true
        needTextView.isHidden = true
        teamFixedLbl.isHidden = true
        publishButton.setTitle(EditProjectDetails.Constants.Texts.nextTitle, for: .normal)
    }
}

extension EditProjectDetailsView {
    
    private func buildCarroussel() {
        invitationsScrollView.contentSize = CGSize(width: (((invitationViews.count + 1) * 150) + (invitationViews.count - 1) * 8) / 2 + 50, height: 86)
        for index in 0..<invitationViews.count {
            invitationViews[index].snp.makeConstraints { make in
                make.height.equalTo(50)
                make.width.equalTo(150)
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
    
    func updateAllTextFields() {
        for view in allSubviews {
            if let textField = view as? WCProjectDataTextField {
                if let isEmpty = textField.text?.isEmpty {
                    if isEmpty {
                        textField.textFieldState = .error
                    } else {
                        textField.textFieldState = .normal
                    }
                }
            }
            if let textView = view as? WCProjectDataTextView, view != needTextView {
                if let isEmpty = textView.text?.isEmpty {
                    if isEmpty {
                        textView.textViewState = .error
                    } else {
                        textView.textViewState = .normal
                    }
                }
            }
        }
    }
}

extension EditProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(projectTitleFixedLbl)
        mainContainer.addSubview(projectTitleTextField)
        mainContainer.addSubview(teamFixedLbl)
        invitationsScrollView.addSubview(invitedFriendsContainer)
        mainContainer.addSubview(invitationsScrollView)
        mainContainer.addSubview(inviteFriendsButton)
        mainContainer.addSubview(sinopsisFixedLbl)
        mainContainer.addSubview(sinopsisTextView)
        mainContainer.addSubview(needLbl)
        mainContainer.addSubview(needTextView)
        mainContainer.addSubview(publishButton)
        mainScrollView.addSubview(mainContainer)
        addSubview(mainScrollView)
    }
    
    func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        projectTitleFixedLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.equalToSuperview().inset(9)
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
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(needTextView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(70)
        }
        invitationsScrollView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(110)
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
            make.top.equalTo(inviteFriendsButton.snp.bottom).offset(48)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
    }
}
