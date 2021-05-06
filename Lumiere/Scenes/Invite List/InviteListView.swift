//
//  InviteListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class InviteListView: BaseView {
    
    private unowned var searchTextField: UITextField
    private unowned var tableView: UITableView
    
    private lazy var inviteLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.text = InviteList.Constants.Texts.inviteLbl
        view.font = InviteList.Constants.Fonts.inviteLbl
        view.textColor = InviteList.Constants.Colors.inviteLbl
        return view
    }()
    
    init(frame: CGRect,
         searchTextField: UITextField,
         tableView: UITableView) {
        self.searchTextField = searchTextField
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func hideHeaderElements() {
        inviteLbl.isHidden = true
        searchTextField.isHidden = true
    }
}

extension InviteListView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(inviteLbl)
        addSubview(searchTextField)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        inviteLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(46)
            make.width.equalTo(191)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(inviteLbl.snp.bottom).offset(16)
            make.left.equalTo(inviteLbl)
            make.right.equalToSuperview().inset(47)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
