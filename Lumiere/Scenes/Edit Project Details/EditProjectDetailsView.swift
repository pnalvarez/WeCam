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
    
    private unowned var inviteFriendsButton: WCSecondaryButton
    private unowned var projectTitleTextField: WCDataTextField
    private unowned var sinopsisTextView: WCDataTextView
    private unowned var needTextView: WCDataTextView
    private unowned var teamFixedLbl: UILabel
    private unowned var invitationsCollectionView: UICollectionView
    private unowned var publishButton: WCPrimaryActionButton
    private unowned var invitationsStackView: UIStackView
    
    private lazy var mainScrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
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
         inviteFriendsButton: WCSecondaryButton,
         projectTitleTextField: WCDataTextField,
         sinopsisTextView: WCDataTextView,
         needTextView: WCDataTextView,
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
            if let textField = view as? WCDataTextField {
                if let isEmpty = textField.text?.isEmpty {
                    if isEmpty {
                        textField.textFieldState = .error
                    } else {
                        textField.textFieldState = .normal
                    }
                }
            }
            if let textView = view as? WCDataTextView, view != needTextView {
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
        mainScrollView.addSubview(projectTitleFixedLbl)
        mainScrollView.addSubview(projectTitleTextField)
        mainScrollView.addSubview(sinopsisFixedLbl)
        mainScrollView.addSubview(sinopsisTextView)
        mainScrollView.addSubview(needLbl)
        mainScrollView.addSubview(needTextView)
        invitationsStackView.addArrangedSubview(teamFixedLbl)
        invitationsStackView.addArrangedSubview(invitationsCollectionView)
        invitationsStackView.addArrangedSubview(inviteFriendsButton)
        mainScrollView.addSubview(invitationsStackView)
        mainScrollView.addSubview(publishButton)
        addSubview(mainScrollView)
    }
    
    func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        projectTitleFixedLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.left.right.equalToSuperview().inset(31)
        }
        projectTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(projectTitleFixedLbl)
            make.right.equalToSuperview().inset(31)
        }
        sinopsisFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(projectTitleTextField.snp.bottom).offset(20)
            make.left.right.equalTo(projectTitleFixedLbl)
        }
        sinopsisTextView.snp.makeConstraints { make in
            make.top.equalTo(sinopsisFixedLbl.snp.bottom).offset(5)
            make.left.right.equalTo(sinopsisFixedLbl)
        }
        needLbl.snp.makeConstraints { make in
            make.top.equalTo(sinopsisTextView.snp.bottom).offset(20)
            make.left.right.equalTo(sinopsisTextView)
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
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        publishButton.snp.makeConstraints { make in
            make.top.equalTo(invitationsStackView.snp.bottom).offset(80)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalTo(invitationsStackView)
            make.width.equalTo(171)
        }
    }
}
