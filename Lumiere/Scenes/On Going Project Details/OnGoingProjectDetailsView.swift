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
    
    private unowned var editProgressView: EditProgressView
    private unowned var editProgressTranslucentView: UIView
    private unowned var confirmationModalView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var teamCollectionView: UICollectionView
    private unowned var progressButton: UIButton
    private unowned var moreInfoButton: UIButton
    private unowned var projectImageView: WCRelevantItemImageView
    private unowned var inviteContactsButton: UIButton
    private unowned var interactionButton: UIButton
    private unowned var projectTitleDescriptionEditableView: WCTitleDescriptionEditableView
    private unowned var projectBulletNeedingEditableView: WCBulletEditableItemView
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.contentSize = CGSize(width: view.frame.width, height: 1000)
        view.backgroundColor = .white
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
    
    private lazy var mainContainer: WCContentView = {
        let view = WCContentView(frame: .zero)
        view.style = .white
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
         editProgressView: EditProgressView,
         editProgressTranslucentView: UIView,
         confirmationModalView: ConfirmationAlertView,
         translucentView: UIView,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton,
         progressButton: UIButton,
         projectImageView: WCRelevantItemImageView,
         inviteContactsButton: UIButton,
         interactionButton: UIButton,
         projectTitleDescriptionEditableView: WCTitleDescriptionEditableView,
         projectBulletNeedingEditableView: WCBulletEditableItemView) {
        self.editProgressView = editProgressView
        self.editProgressTranslucentView = editProgressTranslucentView
        self.confirmationModalView = confirmationModalView
        self.translucentView = translucentView
        self.teamCollectionView = teamCollectionView
        self.moreInfoButton = moreInfoButton
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
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionAuthor, for: .normal)
            inviteContactsButton.isHidden = false
            changeImageLbl.isHidden = false
            projectImageView.isUserInteractionEnabled = true
            progressButton.isUserInteractionEnabled = false
            projectTitleDescriptionEditableView.state = .default
            projectBulletNeedingEditableView.state = .default
        case .simpleParticipating:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionSimpleParticipating, for: .normal)
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = true
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .sentRequest:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionSentRequest, for: .normal)
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = true
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .receivedRequest:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionReceivedRequest, for: .normal)
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = true
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        case .nothing:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionNothing, for: .normal)
            inviteContactsButton.isHidden = true
            changeImageLbl.isHidden = true
            projectImageView.isUserInteractionEnabled = false
            progressButton.isUserInteractionEnabled = true
            projectTitleDescriptionEditableView.state = .disabled
            projectBulletNeedingEditableView.state = .disabled
        }
    }
    
    func displayConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        switch  relation.relation {
        case .author:
            confirmationModalView.setupText(OnGoingProjectDetails.Constants.Texts.authorModalText)
        case .simpleParticipating:
            confirmationModalView.setupText(OnGoingProjectDetails.Constants.Texts.simpleParticipatingModalText)
        case .receivedRequest:
            confirmationModalView.setupText(OnGoingProjectDetails.Constants.Texts.receivedRequestModalText)
        case .sentRequest:
            confirmationModalView.setupText(OnGoingProjectDetails.Constants.Texts.sentRequestModalText)
        case .nothing:
            confirmationModalView.setupText(OnGoingProjectDetails.Constants.Texts.nothingModalText)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = false
            self.confirmationModalView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationModal() {
        self.translucentView.isHidden = true
        self.confirmationModalView.snp.remakeConstraints { make in
            make.top.equalTo(self.translucentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.translucentView)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func displayEditProgressView(withProgress progress: Float) {
        editProgressView.progress = progress
        UIView.animate(withDuration: 0.2, animations: {
            self.editProgressTranslucentView.isHidden = false
            self.editProgressView.snp.remakeConstraints { make in
                make.top.equalTo(self.editProgressTranslucentView.snp.centerY)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.editProgressTranslucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideEditProgressView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.editProgressTranslucentView.isHidden = true
            self.editProgressView.snp.remakeConstraints { make in
                make.top.equalTo(self.editProgressTranslucentView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.editProgressTranslucentView)
            }
            self.layoutIfNeeded()
        })
    }
}

extension OnGoingProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(cathegoryLbl)
        imageStackView.addArrangedSubview(projectImageView)
        imageStackView.addArrangedSubview(changeImageLbl)
        mainContainer.addSubview(progressButton)
        mainContainer.addSubview(progressFixedLbl)
        mainContainer.addSubview(imageStackView)
        mainContainer.addSubview(projectTitleDescriptionEditableView)
        mainContainer.addSubview(projectBulletNeedingEditableView)
        mainContainer.addSubview(teamFixedLbl)
        mainContainer.addSubview(teamCollectionView)
        mainContainer.addSubview(moreInfoButton)
        mainContainer.addSubview(inviteContactsButton)
        mainContainer.addSubview(interactionButton)
        mainScrollView.addSubview(mainContainer)
        addSubview(mainScrollView)
        addSubview(translucentView)
        addSubview(editProgressTranslucentView)
        addSubview(confirmationModalView)
        addSubview(editProgressView)
    }
    
    func setupConstraints() {
        confirmationModalView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        cathegoryLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        progressButton.snp.makeConstraints { make in
            make.top.equalTo(imageStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(16)
        }
        progressFixedLbl.snp.makeConstraints { make in
            make.centerY.equalTo(progressButton)
            make.width.equalTo(70)
            make.left.equalTo(progressButton.snp.right)
        }
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(cathegoryLbl.snp.bottom).offset(28)
            make.left.right.equalToSuperview()
        }
        projectImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
        }
        changeImageLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
        }
        projectTitleDescriptionEditableView.snp.makeConstraints { make in
            make.top.equalTo(progressFixedLbl.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(180)
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
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(teamCollectionView.snp.bottom).offset(12)
            make.right.equalTo(teamCollectionView).offset(-10)
            make.height.equalTo(19)
            make.width.equalTo(103)
        }
        inviteContactsButton.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(10)
            make.left.equalTo(teamFixedLbl)
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        interactionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(768)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(120)
            make.bottom.equalToSuperview().inset(30)
        }
        editProgressTranslucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        editProgressView.snp.makeConstraints { make in
            make.top.equalTo(editProgressTranslucentView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(editProgressTranslucentView)
        }
    }
    
    func configureViews() {
        cathegoryLbl.attributedText = viewModel?.cathegories
        progressButton.setAttributedTitle(viewModel?.progress, for: .normal)
        projectImageView.setupImage(viewModel?.image ?? .empty)
    }
}
