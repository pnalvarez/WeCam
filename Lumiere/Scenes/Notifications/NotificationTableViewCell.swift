//
//  NotificationTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol NotificationTableViewCellDelegate: class {
    func didTapYesButton(index: Int)
    func didTapNoButton(index: Int)
}

class NotificationTableViewCell: UITableViewCell {
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 45
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = Notifications.Constants.Fonts.nameLbl
        view.textColor = Notifications.Constants.Colors.nameLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = Notifications.Constants.Fonts.ocupationLbl
        view.textColor = Notifications.Constants.Colors.ocupationLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    private lazy var phoneNumberLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = Notifications.Constants.Fonts.phoneNumberLbl
        view.textColor = Notifications.Constants.Colors.phoneNumberLbl
        return view
    }()
    
    private lazy var notificationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = Notifications.Constants.Fonts.notificationLbl
        view.textColor = Notifications.Constants.Colors.notificationLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var yesButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapYesButton), for: .touchUpInside)
        view.backgroundColor = Notifications.Constants.Colors.yesButtonBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = Notifications.Constants.Colors.yesButtonLayer
        view.setTitle(Notifications.Constants.Texts.yesButton, for: .normal)
        view.titleLabel?.font = Notifications.Constants.Fonts.yesButtonLbl
        view.setTitleColor(Notifications.Constants.Colors.yesButtonBackground, for: .normal)
        view.backgroundColor = Notifications.Constants.Colors.yesButtonBackground
        return view
    }()
    
    private lazy var noButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapNoButton), for: .touchUpInside)
        view.backgroundColor = Notifications.Constants.Colors.noButtonBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = Notifications.Constants.Colors.noButtonLayer
        view.setTitle(Notifications.Constants.Texts.noButton, for: .normal)
        view.titleLabel?.font = Notifications.Constants.Fonts.noButtonLbl
        view.setTitleColor(Notifications.Constants.Colors.noButtonBackground, for: .normal)
        view.backgroundColor = Notifications.Constants.Colors.noButtonBackground
        return view
    }()
    
    private var index: Int?
    
    private weak var delegate: NotificationTableViewCellDelegate?
    
    private var viewModel: Notifications.Info.ViewModel.Notification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: Notifications.Info.ViewModel.Notification? = nil,
               index: Int,
               delegate: NotificationTableViewCellDelegate? = nil) {
        self.viewModel = viewModel
        self.index = index
        self.delegate = delegate
        applyViewCode()
    }
}

extension NotificationTableViewCell {
    
    @objc
    private func didTapYesButton() {
        delegate?.didTapYesButton(index: index ?? 0)
    }
    
    @objc
    private func didTapNoButton() {
        delegate?.didTapNoButton(index: index ?? 0)
    }
}

extension NotificationTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(profileImageView)
        addSubview(nameLbl)
        addSubview(emailLbl)
        addSubview(ocupationLbl)
        addSubview(phoneNumberLbl)
        addSubview(notificationLbl)
        addSubview(yesButton)
        addSubview(noButton)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(11)
            make.height.width.equalTo(90)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.equalTo(profileImageView.snp.right).offset(18)
            make.width.equalTo(144)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.width.equalTo(nameLbl)
        }
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(ocupationLbl.snp.bottom)
            make.left.equalTo(ocupationLbl)
            make.width.equalTo(ocupationLbl)
        }
        phoneNumberLbl.snp.makeConstraints { make in
            make.top.equalTo(emailLbl.snp.bottom)
            make.left.equalTo(emailLbl)
            make.width.equalTo(emailLbl)
        }
        notificationLbl.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLbl.snp.bottom).offset(1)
            make.left.equalTo(phoneNumberLbl)
            make.width.equalTo(223)
        }
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(notificationLbl.snp.bottom).offset(20)
            make.left.equalTo(profileImageView.snp.right).offset(41)
            make.height.equalTo(28)
            make.width.equalTo(56)
        }
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton)
            make.left.equalTo(yesButton.snp.right).offset(20)
            make.height.equalTo(28)
            make.width.equalTo(56)
        }
    }
    
    func configureViews() {
        backgroundColor = Notifications.Constants.Colors.background
        profileImageView.image = viewModel?.image
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
        emailLbl.attributedText = viewModel?.email
        phoneNumberLbl.text = viewModel?.phoneNumber
    }
}
