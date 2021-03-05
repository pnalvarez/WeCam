//
//  AccountRecoveryView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

class AccountRecoveryView: UIView {
    
    private lazy var headerView: DefaultHeaderView = {
        let view = DefaultHeaderView(frame: .zero)
        return view
    }()
    
    private unowned var closeButton: DefaultCloseButton
    private unowned var messageLbl: UILabel
    private unowned var inputTextField: DefaultInputTextField
    private unowned var userDisplayView: UserDisplayView
    private unowned var actionButton: DefaultActionButton
    private unowned var activityView: UIActivityIndicatorView
    
    init(frame: CGRect,
         closeButton: DefaultCloseButton,
         messageLbl: UILabel,
         inputTextField: DefaultInputTextField,
         userDisplayView: UserDisplayView,
         actionButton: DefaultActionButton,
         activityView: UIActivityIndicatorView) {
        self.closeButton = closeButton
        self.messageLbl = messageLbl
        self.inputTextField = inputTextField
        self.userDisplayView = userDisplayView
        self.actionButton = actionButton
        self.activityView = activityView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountRecoveryView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(headerView)
        addSubview(closeButton)
        addSubview(messageLbl)
        addSubview(inputTextField)
        addSubview(userDisplayView)
        addSubview(actionButton)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(94)
            make.height.equalTo(34)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(headerView)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(31)
        }
        messageLbl.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(65)
            make.left.right.equalToSuperview().inset(49)
        }
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(messageLbl.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(22)
        }
        userDisplayView.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(93)
            make.centerX.equalToSuperview()
            make.width.equalTo(274)
            make.height.equalTo(98)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(387)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(30)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
