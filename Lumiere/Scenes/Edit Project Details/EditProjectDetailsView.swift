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
    private unowned var teamFixedLbl: UILabel
    private unowned var invitationsCollectionView: UICollectionView
    private unowned var publishButton: WCPrimaryActionButton
    private unowned var invitationsStackView: UIStackView
    
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
         teamFixedLbl: UILabel,
         invitationsStackView: UIStackView,
         invitationsCollectionView: UICollectionView,
         publishButton: WCPrimaryActionButton) {
        self.inviteFriendsButton = inviteFriendsButton
        self.projectTitleTextField = projectTitleTextField
        self.sinopsisTextView = sinopsisTextView
        self.needTextView = needTextView
        self.teamFixedLbl = teamFixedLbl
        self.invitationsStackView = invitationsStackView
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
        publishButton.text = EditProjectDetails.Constants.Texts.nextTitle
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
        mainContainer.addSubview(sinopsisFixedLbl)
        mainContainer.addSubview(sinopsisTextView)
        mainContainer.addSubview(needLbl)
        mainContainer.addSubview(needTextView)
        invitationsStackView.addArrangedSubview(teamFixedLbl)
        invitationsStackView.addArrangedSubview(invitationsCollectionView)
        invitationsStackView.addArrangedSubview(inviteFriendsButton)
        mainContainer.addSubview(invitationsStackView)
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
            make.right.equalTo(sinopsisTextView)
        }
        invitationsStackView.snp.makeConstraints { make in
            make.top.equalTo(needTextView.snp.bottom).offset(36)
            make.left.right.equalToSuperview()
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(31)
            make.right.equalToSuperview().inset(48)
        }
        invitationsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(108)
        }
        inviteFriendsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        publishButton.snp.makeConstraints { make in
            make.top.equalTo(invitationsStackView.snp.bottom).offset(80)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
    }
}
