//
//  InviteListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class InviteListView: UIView {
    
    private unowned var backButton: WCBackButton
    private unowned var loadingView: WCLoadingView
    private unowned var activityView: UIActivityIndicatorView
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
         backButton: WCBackButton,
         loadingView: WCLoadingView,
         activityView: UIActivityIndicatorView,
         searchTextField: UITextField,
         tableView: UITableView) {
        self.backButton = backButton
        self.loadingView = loadingView
        self.activityView = activityView
        self.searchTextField = searchTextField
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}

extension InviteListView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(inviteLbl)
        addSubview(searchTextField)
        addSubview(tableView)
        addSubview(activityView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(31)
            make.size.equalTo(31)
        }
        inviteLbl.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(17)
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
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
