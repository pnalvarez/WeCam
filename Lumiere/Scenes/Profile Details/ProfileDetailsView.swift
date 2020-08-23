//
//  ProfileDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileDetailsView: UIView {
    
    private unowned var confirmationAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var backButton: UIButton
    private unowned var addConnectionButton: UIButton
    private unowned var allConnectionsButton: UIButton
    private unowned var editProfileButton: UIButton
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 35
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 42.75
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
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
    
    private var viewModel: ProfileDetails.Info.ViewModel.User?
    
    init(frame: CGRect,
         confirmationAlertView: ConfirmationAlertView,
         translucentView: UIView,
         backButton: UIButton,
         addConnectionButton: UIButton,
         allConnectionsButton: UIButton,
         editProfileButton: UIButton) {
        self.confirmationAlertView = confirmationAlertView
        self.translucentView = translucentView
        self.backButton = backButton
        self.addConnectionButton = addConnectionButton
        self.allConnectionsButton = allConnectionsButton
        self.editProfileButton = editProfileButton
        super.init(frame: frame)
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
        addSubview(backButton)
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(occupationLbl)
        addSubview(emailLbl)
        addSubview(phoneNumberLbl)
        addSubview(addConnectionButton)
        buttonStackView.addArrangedSubview(editProfileButton)
        buttonStackView.addArrangedSubview(allConnectionsButton)
        addSubview(buttonStackView)
//        addSubview(allConnectionsButton)
        addSubview(translucentView)
        addSubview(confirmationAlertView)
    }
    
    func setupConstraints() {
        confirmationAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
        translucentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(28)
            make.left.equalToSuperview().inset(28)
            make.height.equalTo(30.44)
            make.width.equalTo(32)
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(37)
            make.height.width.equalTo(84)
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
        addConnectionButton.snp.makeConstraints { make in
            make.top.equalTo(nameLbl).offset(-2)
            make.right.equalToSuperview().inset(26)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
        }
        allConnectionsButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
//            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(171)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        allConnectionsButton.setAttributedTitle(viewModel?.connectionsCount, for: .normal)
        nameLbl.attributedText = viewModel?.name
        occupationLbl.attributedText = viewModel?.occupation
        emailLbl.attributedText = viewModel?.email
        phoneNumberLbl.attributedText = viewModel?.phoneNumber
        addConnectionButton.setImage(viewModel?.connectionTypeImage, for: .normal)
        guard let image = viewModel?.image else {
            return
        }
        photoImageView.sd_setImage(with: URL(string: image), completed: nil)
    }
}
