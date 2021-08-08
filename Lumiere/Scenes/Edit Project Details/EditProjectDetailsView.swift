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
    private unowned var projectTitleTextField: WCDataInputTextFieldView
    private unowned var sinopsisTextView: WCDataInputTextFieldView
    private unowned var needTextView: WCDataInputTextFieldView
    private unowned var teamFixedLbl: WCUILabelRobotoRegular16Gray
    private unowned var invitationsCollectionView: UICollectionView
    private unowned var publishButton: WCPrimaryActionButton
    private unowned var invitationsStackView: UIStackView
    
    private lazy var mainScrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()
    
    private lazy var inputDataStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = EditProjectDetails.Constants.BusinessLogic.dataInfoStackSpacing
        return view
    }()
    
    init(frame: CGRect,
         inviteFriendsButton: WCSecondaryButton,
         projectTitleTextField: WCDataInputTextFieldView,
         sinopsisTextView: WCDataInputTextFieldView,
         needTextView: WCDataInputTextFieldView,
         teamFixedLbl: WCUILabelRobotoRegular16Gray,
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
        projectTitleTextField.textViewState = .normal
    }
    
    func updateForFinishedProject() {
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
        inputDataStackView.addArrangedSubviews(projectTitleTextField, sinopsisTextView, needTextView)
        mainScrollView.addSubview(inputDataStackView)
        invitationsStackView.addArrangedSubviews(teamFixedLbl, invitationsCollectionView, inviteFriendsButton, publishButton)
        invitationsStackView.insertSpacing(of: 60, after: inviteFriendsButton)
        mainScrollView.addSubview(invitationsStackView)
        addSubview(mainScrollView)
    }
    
    func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        inputDataStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.left.right.equalToSuperview().inset(31)
        }
        invitationsStackView.snp.makeConstraints { make in
            make.top.equalTo(inputDataStackView.snp.bottom).offset(36)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
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
            make.left.right.equalToSuperview().inset(24)
        }
        publishButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(96)
        }
    }
}
