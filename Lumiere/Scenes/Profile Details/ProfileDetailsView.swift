//
//  ProfileDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit
import SDWebImage

class ProfileDetailsView: BaseView {
    
    private unowned var ongoingProjectsCollectionView: UICollectionView
    private unowned var finishedProjectsCollectionView: UICollectionView
    private unowned var confirmationAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var inviteToProjectButton: UIButton
    private unowned var addConnectionButton: UIButton
    private unowned var allConnectionsButton: UIButton
    private unowned var editProfileButton: UIButton
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 35
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var occupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var phoneNumberLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var onGoingProjectsLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileDetails.Constants.Texts.onGoingProjectsLbl
        view.font = ProfileDetails.Constants.Fonts.onGoingProjectsLbl
        view.textColor = ProfileDetails.Constants.Colors.onGoingProjectsLbl
        return view
    }()
    
    private lazy var finishedProjectsLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileDetails.Constants.Texts.finishedProjectsLbl
        view.textColor = ProfileDetails.Constants.Colors.finishedProjectsLbl
        view.font = ProfileDetails.Constants.Fonts.finishedProjectsLbl
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.contentSize = CGSize(width: frame.width, height: 200)
        return view
    }()
    
    private lazy var mainContainer: WCContentView = {
        let view = WCContentView(frame: .zero)
        view.style = .white
        return view
    }()
    
    private var viewModel: ProfileDetails.Info.ViewModel.User?
    
    init(frame: CGRect,
         ongoingProjectsCollectionView: UICollectionView,
         finishedProjectsCollectionView: UICollectionView,
         confirmationAlertView: ConfirmationAlertView,
         translucentView: UIView,
         inviteToProjectButton: UIButton,
         addConnectionButton: UIButton,
         allConnectionsButton: UIButton,
         editProfileButton: UIButton) {
        self.ongoingProjectsCollectionView = ongoingProjectsCollectionView
        self.finishedProjectsCollectionView = finishedProjectsCollectionView
        self.confirmationAlertView = confirmationAlertView
        self.translucentView = translucentView
        self.inviteToProjectButton = inviteToProjectButton
        self.addConnectionButton = addConnectionButton
        self.allConnectionsButton = allConnectionsButton
        self.editProfileButton = editProfileButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ProfileDetails.Info.ViewModel.User) {
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func displayConfirmationView(withText text: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.confirmationAlertView.setupText(text)
            self.translucentView.isHidden = false
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.size.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = true
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.bottom)
                make.size.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
}

extension ProfileDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(photoImageView)
        mainContainer.addSubview(nameLbl)
        mainContainer.addSubview(occupationLbl)
        mainContainer.addSubview(emailLbl)
        mainContainer.addSubview(phoneNumberLbl)
        mainContainer.addSubview(inviteToProjectButton)
        mainContainer.addSubview(addConnectionButton)
        buttonStackView.addArrangedSubview(editProfileButton)
        buttonStackView.addArrangedSubview(allConnectionsButton)
        mainContainer.addSubview(buttonStackView)
        mainContainer.addSubview(onGoingProjectsLbl)
        mainContainer.addSubview(ongoingProjectsCollectionView)
        mainContainer.addSubview(finishedProjectsCollectionView)
        mainContainer.addSubview(finishedProjectsLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(translucentView)
        addSubview(confirmationAlertView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        confirmationAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
        translucentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(56)
            make.left.equalToSuperview().inset(37)
            make.width.equalTo(84)
        }
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(14)
            make.top.equalTo(photoImageView)
            make.width.equalTo(181)
        }
        occupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.width.equalTo(nameLbl)
        }
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(occupationLbl.snp.bottom)
            make.left.width.equalTo(occupationLbl)
        }
        phoneNumberLbl.snp.makeConstraints { make in
            make.top.equalTo(emailLbl.snp.bottom)
            make.left.width.equalTo(emailLbl)
        }
        inviteToProjectButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(10)
            make.left.equalTo(phoneNumberLbl)
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        addConnectionButton.snp.makeConstraints { make in
            make.top.equalTo(nameLbl).offset(-2)
            make.right.equalToSuperview().inset(26)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(59)
            make.centerX.equalToSuperview()
            make.width.equalTo(359)
        }
        editProfileButton.snp.makeConstraints { make in
            make.height.equalTo(29)
            make.left.right.equalToSuperview().inset(37)
        }
        allConnectionsButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
        onGoingProjectsLbl.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(46)
            make.left.equalToSuperview().inset(26)
            make.width.equalTo(208)
        }
        ongoingProjectsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(onGoingProjectsLbl.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
        finishedProjectsLbl.snp.makeConstraints { make in
            make.top.equalTo(ongoingProjectsCollectionView.snp.bottom).offset(57)
            make.left.width.equalTo(onGoingProjectsLbl)
        }
        finishedProjectsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(finishedProjectsLbl.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(182)
        }
    }
    
    func configureViews() {
        scrollView.contentSize = CGSize(width: frame.width, height: 760)
        backgroundColor = .white
        allConnectionsButton.setAttributedTitle(viewModel?.connectionsCount, for: .normal)
        nameLbl.attributedText = viewModel?.name
        occupationLbl.attributedText = viewModel?.occupation
        emailLbl.attributedText = viewModel?.email
        phoneNumberLbl.attributedText = viewModel?.phoneNumber
        addConnectionButton.setImage(viewModel?.connectionTypeImage, for: .normal)
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
    }
}
