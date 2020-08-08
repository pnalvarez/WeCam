//
//  ProfileDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileDetailsView: UIView {
    
    private unowned var backButton: UIButton
    private unowned var addConnectionButton: UIButton
    private unowned var allConnectionsButton: UIButton
    
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
         backButton: UIButton,
         addConnectionButton: UIButton,
         allConnectionsButton: UIButton) {
        self.backButton = backButton
        self.addConnectionButton = addConnectionButton
        self.allConnectionsButton = allConnectionsButton
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ProfileDetails.Info.ViewModel.User) {
        self.viewModel = viewModel
        applyViewCode()
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
        addSubview(allConnectionsButton)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(7)
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(48)
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(40)
            make.left.equalTo(nameLbl.snp.right).offset(9)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        allConnectionsButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(39)
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
