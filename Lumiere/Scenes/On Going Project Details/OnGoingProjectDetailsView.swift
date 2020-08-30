//
//  OnGoingProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

class OnGoingProjectDetailsView: UIView {
    
    private unowned var confirmationModalView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var closeButton: UIButton
    private unowned var teamCollectionView: UICollectionView
    private unowned var moreInfoButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var inviteContactsButton: UIButton
    private unowned var editButton: UIButton
    private unowned var interactionButton: UIButton
    private unowned var editNeedingButton: UIButton
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
    
    private lazy var infoContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.containerInfoBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectDetails.Constants.Colors.containerInfoLayer
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.titleLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.titleLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var sinopsisLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.sinopsisLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.sinopsisLbl
        view.numberOfLines = 0
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
    
    private lazy var dotView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.dotView
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var needValueLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = OnGoingProjectDetails.Constants.Colors.needValueLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.needValueLbl
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         confirmationModalView: ConfirmationAlertView,
         translucentView: UIView,
         closeButton: UIButton,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton,
         imageButton: UIButton,
         inviteContactsButton: UIButton,
         editButton: UIButton,
         interactionButton: UIButton,
         editNeedingButton: UIButton,
         activityView: UIActivityIndicatorView) {
        self.confirmationModalView = confirmationModalView
        self.translucentView = translucentView
        self.closeButton = closeButton
        self.teamCollectionView = teamCollectionView
        self.moreInfoButton = moreInfoButton
        self.imageButton = imageButton
        self.inviteContactsButton = inviteContactsButton
        self.editButton = editButton
        self.interactionButton = interactionButton
        self.editNeedingButton = editNeedingButton
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
}

extension OnGoingProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(closeButton)
        imageStackView.addArrangedSubview(imageButton)
        imageStackView.addArrangedSubview(changeImageLbl)
        mainContainer.addSubview(imageStackView)
        infoContainer.addSubview(titleLbl)
        infoContainer.addSubview(editButton)
        infoContainer.addSubview(sinopsisLbl)
        mainContainer.addSubview(infoContainer)
        mainContainer.addSubview(teamFixedLbl)
        mainContainer.addSubview(teamCollectionView)
        mainContainer.addSubview(moreInfoButton)
        mainContainer.addSubview(needFixedLbl)
        mainContainer.addSubview(dotView)
        mainContainer.addSubview(needValueLbl)
        mainContainer.addSubview(editNeedingButton)
        mainContainer.addSubview(inviteContactsButton)
        mainContainer.addSubview(interactionButton)
        mainContainer.addSubview(activityView)
        mainScrollView.addSubview(mainContainer)
        addSubview(mainScrollView)
        addSubview(translucentView)
        addSubview(confirmationModalView)
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
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.right.equalToSuperview().inset(35)
            make.height.width.equalTo(31)
        }
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
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
            make.top.equalTo(imageStackView.snp.bottom).offset(14)
            make.left.equalToSuperview().inset(56)
            make.right.equalToSuperview().inset(51)
            make.height.equalTo(88)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(14)
            make.width.equalTo(38)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.right.equalToSuperview()
        }
        sinopsisLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(infoContainer.snp.bottom).offset(19)
            make.left.equalTo(infoContainer)
            make.width.equalTo(49)
        }
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(17)
            make.left.equalTo(teamFixedLbl)
            make.right.equalToSuperview().inset(59)
            make.height.equalTo(115)
        }
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(teamCollectionView.snp.bottom).offset(12)
            make.right.equalTo(teamCollectionView)
            make.height.equalTo(19)
            make.width.equalTo(103)
        }
        needFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(inviteContactsButton.snp.bottom).offset(50)
            make.left.equalTo(teamCollectionView)
            make.width.equalTo(94)
        }
        dotView.snp.makeConstraints { make in
            make.top.equalTo(needFixedLbl.snp.bottom).offset(18)
            make.left.equalTo(needFixedLbl)
            make.height.width.equalTo(10)
        }
        needValueLbl.snp.makeConstraints { make in
            make.centerY.equalTo(dotView)
            make.left.equalTo(dotView.snp.right).offset(12)
            make.width.equalTo(200)
        }
        editNeedingButton.snp.makeConstraints { make in
            make.centerY.equalTo(dotView)
            make.left.equalTo(needValueLbl.snp.right)
            make.height.equalTo(14)
            make.height.equalTo(38)
        }
        inviteContactsButton.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        interactionButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton).offset(670)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(107)
            make.bottom.equalToSuperview().inset(69)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        titleLbl.text = viewModel?.title
        sinopsisLbl.text = viewModel?.sinopsis
        needValueLbl.text = viewModel?.needing
        guard let image = viewModel?.image else { return }
        imageButton.sd_setImage(with: URL(string: image), for: .normal, completed: nil)
        imageButton.isUserInteractionEnabled = false
    }
}
