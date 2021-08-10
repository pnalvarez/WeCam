//
//  InviteProfileToProjectsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class InviteProfileToProjectsView: BaseView {
    
    private unowned var searchTextField: WCDataTextField
    private unowned var tableView: UITableView
    
    private lazy var mainLbl: WCUILabelRobotoRegular16 = {
        let view = WCUILabelRobotoRegular16(frame: .zero)
        view.text = InviteProfileToProjects.Constants.Texts.mainLbl
        return view
    }()
    
    init(frame: CGRect,
         searchTextField: WCDataTextField,
         tableView: UITableView) {
        self.searchTextField = searchTextField
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InviteProfileToProjectsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(mainLbl)
        addSubview(searchTextField)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        mainLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLbl.snp.bottom).offset(24)
            make.centerX.equalTo(mainLbl)
            make.width.equalTo(306)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(18)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
