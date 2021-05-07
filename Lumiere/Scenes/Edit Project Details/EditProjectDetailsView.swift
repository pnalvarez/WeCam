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
    private unowned var invitationsCollectionView: UICollectionView
    private unowned var publishButton: WCActionButton
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = true
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
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
    
    init(frame: CGRect,
         inviteFriendsButton: UIButton,
         projectTitleTextField: WCProjectDataTextField,
         sinopsisTextView: WCProjectDataTextView,
         needTextView: WCProjectDataTextView,
         invitationsCollectionView: UICollectionView,
         publishButton: WCActionButton) {
        self.inviteFriendsButton = inviteFriendsButton
        self.projectTitleTextField = projectTitleTextField
        self.sinopsisTextView = sinopsisTextView
        self.needTextView = needTextView
        self.invitationsCollectionView = invitationsCollectionView
        self.publishButton = publishButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        mainContainer.addSubview(inviteFriendsButton)
        mainContainer.addSubview(sinopsisFixedLbl)
        mainContainer.addSubview(sinopsisTextView)
        mainContainer.addSubview(needLbl)
        mainContainer.addSubview(needTextView)
        mainContainer.addSubview(invitationsCollectionView)
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
            make.top.equalToSuperview().inset(84)
            make.left.equalToSuperview().inset(31)
            make.width.equalTo(200)
        }
        projectTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(projectTitleFixedLbl)
            make.right.equalToSuperview().inset(48)
        }
        sinopsisFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(projectTitleTextField.snp.bottom).offset(20)
            make.left.equalTo(projectTitleFixedLbl)
            make.right.equalToSuperview().inset(65)
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
            make.right.equalToSuperview().inset(64)
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(needTextView.snp.bottom).offset(36)
            make.left.equalTo(needTextView)
            make.width.equalTo(70)
        }
        invitationsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.height.equalTo(108)
        }
        inviteFriendsButton.snp.makeConstraints { make in
            make.top.equalTo(invitationsCollectionView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        publishButton.snp.makeConstraints { make in
            make.top.equalTo(inviteFriendsButton.snp.bottom).offset(80)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
    }
}
