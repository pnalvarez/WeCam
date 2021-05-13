//
//  AccountRecoveryView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class AccountRecoveryView: BaseView {
    
    private lazy var headerView: WCHeaderView = {
        let view = WCHeaderView(frame: .zero)
        return view
    }()
    
    private unowned var messageLbl: UILabel
    private unowned var searchTextField: WCSearchTextField
    private unowned var userDisplayView: WCUserDisplayView
    private unowned var sendEmailButton: WCActionButton
    
    init(frame: CGRect,
         messageLbl: UILabel,
         searchTextField: WCSearchTextField,
         userDisplayView: WCUserDisplayView,
         sendEmailButton: WCActionButton) {
        self.messageLbl = messageLbl
        self.searchTextField = searchTextField
        self.userDisplayView = userDisplayView
        self.sendEmailButton = sendEmailButton
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
        addSubview(messageLbl)
        addSubview(searchTextField)
        addSubview(userDisplayView)
        addSubview(sendEmailButton)
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(94)
        }
        messageLbl.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(65)
            make.left.right.equalToSuperview().inset(49)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(messageLbl.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(22)
        }
        userDisplayView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(93)
            make.centerX.equalToSuperview()
            make.width.equalTo(274)
        }
        sendEmailButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(387)
            make.left.right.equalToSuperview().inset(110)
        }
    }
}
