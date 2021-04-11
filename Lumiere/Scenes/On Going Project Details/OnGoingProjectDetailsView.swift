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

class OnGoingProjectDetailsView: UIView {
    
    private unowned var backButton: WCBackButton
    private unowned var editProgressView: EditProgressView
    private unowned var editProgressTranslucentView: UIView
    private unowned var confirmationModalView: ConfirmationAlertView
    private unowned var titleTextField: UITextField
    private unowned var sinopsisTextView: UITextView
    private unowned var translucentView: UIView
    private unowned var closeButton: UIButton
    private unowned var teamCollectionView: UICollectionView
    private unowned var progressButton: UIButton
    private unowned var moreInfoButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var inviteContactsButton: UIButton
    private unowned var editButton: UIButton
    private unowned var cancelEditingDetailsButton: WCCloseButton
    private unowned var interactionButton: UIButton
    private unowned var editNeedingButton: UIButton
    private unowned var cancelEditingNeedingButton: WCCloseButton
    private unowned var needValueTextfield: UITextField
    private unowned var activityView: UIActivityIndicatorView
    
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
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
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
    
    private lazy var infoContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.containerInfoBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectDetails.Constants.Colors.containerInfoLayer
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var editDetailsStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 3
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
    
    private lazy var needFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.needFixedLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.needFixedLbl
        view.textColor = OnGoingProjectDetails.Constants.Colors.needFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var needingStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 1
        return view
    }()
    
    private lazy var dotView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.dotView
        view.layer.cornerRadius = 5
        return view
    }()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         backButton: WCBackButton,
         editProgressView: EditProgressView,
         editProgressTranslucentView: UIView,
         titleTextField: UITextField,
         sinopsisTextView: UITextView,
         confirmationModalView: ConfirmationAlertView,
         translucentView: UIView,
         closeButton: UIButton,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton,
         progressButton: UIButton,
         imageButton: UIButton,
         inviteContactsButton: UIButton,
         editButton: UIButton,
         cancelEditingDetailsButton: WCCloseButton,
         interactionButton: UIButton,
         editNeedingButton: UIButton,
         cancelEditingNeedingButton: WCCloseButton,
         needValueTextfield: UITextField,
         activityView: UIActivityIndicatorView) {
        self.backButton = backButton
        self.editProgressView = editProgressView
        self.editProgressTranslucentView = editProgressTranslucentView
        self.confirmationModalView = confirmationModalView
        self.titleTextField = titleTextField
        self.sinopsisTextView = sinopsisTextView
        self.translucentView = translucentView
        self.closeButton = closeButton
        self.teamCollectionView = teamCollectionView
        self.moreInfoButton = moreInfoButton
        self.progressButton = progressButton
        self.imageButton = imageButton
        self.inviteContactsButton = inviteContactsButton
        self.editButton = editButton
        self.cancelEditingDetailsButton = cancelEditingDetailsButton
        self.interactionButton = interactionButton
        self.editNeedingButton = editNeedingButton
        self.cancelEditingNeedingButton = cancelEditingNeedingButton
        self.needValueTextfield = needValueTextfield
        self.activityView = activityView
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
            editButton.isHidden = false
            changeImageLbl.isHidden = false
            imageButton.isUserInteractionEnabled = true
            editNeedingButton.isHidden = false
        case .simpleParticipating:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionSimpleParticipating, for: .normal)
            inviteContactsButton.isHidden = true
            editButton.isHidden = true
            changeImageLbl.isHidden = true
            imageButton.isUserInteractionEnabled = false
            editNeedingButton.isHidden = true
        case .sentRequest:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionSentRequest, for: .normal)
            inviteContactsButton.isHidden = true
            editButton.isHidden = true
            changeImageLbl.isHidden = true
            imageButton.isUserInteractionEnabled = false
            editNeedingButton.isHidden = true
        case .receivedRequest:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionReceivedRequest, for: .normal)
            inviteContactsButton.isHidden = true
            editButton.isHidden = true
            changeImageLbl.isHidden = true
            imageButton.isUserInteractionEnabled = false
            editNeedingButton.isHidden = true
        case .nothing:
            interactionButton.setTitle(OnGoingProjectDetails.Constants.Texts.interactionNothing, for: .normal)
            inviteContactsButton.isHidden = true
            editButton.isHidden = true
            changeImageLbl.isHidden = true
            imageButton.isUserInteractionEnabled = false
            editNeedingButton.isHidden = true
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
        mainContainer.addSubview(backButton)
        mainContainer.addSubview(closeButton)
        mainContainer.addSubview(cathegoryLbl)
        imageStackView.addArrangedSubview(imageButton)
        imageStackView.addArrangedSubview(changeImageLbl)
        mainContainer.addSubview(progressButton)
        mainContainer.addSubview(progressFixedLbl)
        mainContainer.addSubview(imageStackView)
        editDetailsStackView.addArrangedSubview(editButton)
        editDetailsStackView.addArrangedSubview(cancelEditingDetailsButton)
        infoContainer.addSubview(titleTextField)
        infoContainer.addSubview(editDetailsStackView)
        infoContainer.addSubview(sinopsisTextView)
        mainContainer.addSubview(infoContainer)
        mainContainer.addSubview(teamFixedLbl)
        mainContainer.addSubview(teamCollectionView)
        mainContainer.addSubview(moreInfoButton)
        mainContainer.addSubview(needFixedLbl)
        mainContainer.addSubview(dotView)
        mainContainer.addSubview(needValueTextfield)
        mainContainer.addSubview(needingStackView)
        needingStackView.addArrangedSubview(editNeedingButton)
        needingStackView.addArrangedSubview(cancelEditingNeedingButton)
        mainContainer.addSubview(inviteContactsButton)
        mainContainer.addSubview(interactionButton)
        mainContainer.addSubview(activityView)
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
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(31)
            make.height.width.equalTo(31)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.right.equalToSuperview().inset(35)
            make.height.width.equalTo(31)
        }
        cathegoryLbl.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        progressButton.snp.makeConstraints { make in
            make.top.equalTo(imageStackView.snp.bottom).offset(20)
            make.centerX.equalTo(infoContainer).offset(-30)
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
            make.centerX.equalToSuperview()
        }
        imageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(82)
        }
        changeImageLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
        }
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(progressButton.snp.bottom).offset(14)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(188)
        }
        editDetailsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(2)
        }
        editButton.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.width.equalTo(46)
        }
        cancelEditingDetailsButton.snp.makeConstraints { make in
            make.height.width.equalTo(14)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.right.equalToSuperview()
        }
        sinopsisTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(30)
            make.left.equalTo(needFixedLbl)
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
        needFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(infoContainer.snp.bottom).offset(30)
            make.left.equalTo(infoContainer).offset(2)
            make.width.equalTo(94)
        }
        dotView.snp.makeConstraints { make in
            make.top.equalTo(needFixedLbl.snp.bottom).offset(18)
            make.left.equalTo(needFixedLbl)
            make.height.width.equalTo(10)
        }
        needValueTextfield.snp.makeConstraints { make in
            make.centerY.equalTo(dotView)
            make.left.equalTo(dotView.snp.right).offset(12)
            make.width.equalTo(200)
        }
        needingStackView.snp.makeConstraints { make in
            make.centerY.equalTo(dotView)
            make.left.equalTo(needValueTextfield.snp.right)
        }
        editNeedingButton.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.width.equalTo(46)
        }
        cancelEditingNeedingButton.snp.makeConstraints { make in
            make.height.width.equalTo(14)
        }
        inviteContactsButton.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(10)
            make.left.equalTo(teamFixedLbl)
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        interactionButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton).offset(760)
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
        backgroundColor = .white
        cathegoryLbl.attributedText = viewModel?.cathegories
        progressButton.setAttributedTitle(viewModel?.progress, for: .normal)
        titleTextField.text = viewModel?.title
        sinopsisTextView.text = viewModel?.sinopsis
        needValueTextfield.text = viewModel?.needing
        guard let image = viewModel?.image else { return }
        imageButton.sd_setImage(with: URL(string: image), for: .normal, completed: nil)
    }
}
