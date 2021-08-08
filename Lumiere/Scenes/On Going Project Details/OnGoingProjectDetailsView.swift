//
//  OnGoingProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

class OnGoingProjectDetailsView: BaseView, ModalViewable {
    
    private unowned var teamCollectionView: UICollectionView
    private unowned var progressButton: UIButton
    private unowned var projectImageView: WCRelevantItemImageView
    private unowned var inviteContactsButton: WCPrimaryActionButton
    private unowned var interactionButton: WCPrimaryActionButton
    private unowned var projectTitleDescriptionEditableView: WCTitleDescriptionEditableView
    private unowned var projectBulletNeedingEditableView: WCBulletEditableItemView
    
    private lazy var mainScrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()
    
    private lazy var cathegoryLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var changeImageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.changeImageLbl
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.changeImageLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.changeImageLbl
        return view
    }()
    
    private lazy var progressStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    private lazy var imageStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.alignment = .center
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 17
        return view
    }()
    
    private lazy var progressFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.progressFixedLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.progressFixedLbl
        view.textColor = OnGoingProjectDetails.Constants.Colors.progressFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var teamFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.teamFixedLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.teamFixedLbl
        view.textColor = OnGoingProjectDetails.Constants.Colors.teamFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         teamCollectionView: UICollectionView,
         progressButton: UIButton,
         projectImageView: WCRelevantItemImageView,
         inviteContactsButton: WCPrimaryActionButton,
         interactionButton: WCPrimaryActionButton,
         projectTitleDescriptionEditableView: WCTitleDescriptionEditableView,
         projectBulletNeedingEditableView: WCBulletEditableItemView) {
        self.teamCollectionView = teamCollectionView
        self.progressButton = progressButton
        self.projectImageView = projectImageView
        self.inviteContactsButton = inviteContactsButton
        self.interactionButton = interactionButton
        self.projectTitleDescriptionEditableView = projectTitleDescriptionEditableView
        self.projectBulletNeedingEditableView = projectBulletNeedingEditableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: OnGoingProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func updateUI(forRelation relation: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        switch  relation.relation {
        case .author:
            interactionButton.text = OnGoingProjectDetails.Constants.Texts.interactionAuthor
            inviteContactsButton.isHidden = false
            changeImageLbl.isHidden = false
            projectImageView.isUserInteractionEnabled = true
            progressButton.isUserInteractionEnabled = true
            projectTitleDescriptionEditableView.state = .default
            projectBulletNeedingEditableView.state = .default
        case .simpleParticipating:
            interactionButton.text = OnGoingProjectDetails.Constants.Texts.interactionSimpleParticipating
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = false
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .sentRequest:
            interactionButton.text = OnGoingProjectDetails.Constants.Texts.interactionSentRequest
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = false
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .receivedRequest:
            interactionButton.text = OnGoingProjectDetails.Constants.Texts.interactionReceivedRequest
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = false
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .nothing:
            interactionButton.text = OnGoingProjectDetails.Constants.Texts.interactionNothing
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = false
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        }
    }
}

extension OnGoingProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainScrollView.addSubview(cathegoryLbl)
        imageStackView.addArrangedSubview(projectImageView)
        imageStackView.addArrangedSubview(changeImageLbl)
        progressStackView.addArrangedSubview(progressButton)
        progressStackView.addArrangedSubview(progressFixedLbl)
        mainScrollView.addSubview(progressStackView)
        mainScrollView.addSubview(imageStackView)
        mainScrollView.addSubview(projectTitleDescriptionEditableView)
        mainScrollView.addSubview(projectBulletNeedingEditableView)
        mainScrollView.addSubview(teamFixedLbl)
        mainScrollView.addSubview(teamCollectionView)
        mainScrollView.addSubview(inviteContactsButton)
        mainScrollView.addSubview(interactionButton)
        addSubview(mainScrollView)
    }
    
    func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cathegoryLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(changeImageLbl.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        progressButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(16)
        }
        progressFixedLbl.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(cathegoryLbl.snp.bottom).offset(28)
            make.left.right.equalToSuperview()
        }
        projectImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
        }
        changeImageLbl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        projectTitleDescriptionEditableView.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(184)
        }
        projectBulletNeedingEditableView.snp.makeConstraints { make in
            make.top.equalTo(projectTitleDescriptionEditableView.snp.bottom).offset(24)
            make.right.left.equalTo(projectTitleDescriptionEditableView)
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(projectBulletNeedingEditableView.snp.bottom).offset(30)
            make.left.equalTo(projectBulletNeedingEditableView)
            make.width.equalTo(49)
        }
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(17)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(115)
        }
        inviteContactsButton.snp.makeConstraints { make in
            make.centerY.equalTo(teamFixedLbl)
            make.left.equalTo(teamFixedLbl.snp.right).offset(4)
            make.width.equalTo(171)
        }
        interactionButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(teamCollectionView).offset(69)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func configureViews() {
        cathegoryLbl.attributedText = viewModel?.cathegories
        progressButton.setAttributedTitle(viewModel?.progress, for: .normal)
        projectImageView.setupImage(viewModel?.image ?? .empty)
    }
}
