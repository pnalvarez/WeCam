//
//  NotificationsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

class NotificationsView: BaseView {
    
    private unowned var criteriaOptionsToolbar: WCOptionsToolbar
    private unowned var tableView: NotificationsTableView
    
    init(frame: CGRect,
         criteriaOptionsToolbar: WCOptionsToolbar,
         tableView: NotificationsTableView) {
        self.criteriaOptionsToolbar = criteriaOptionsToolbar
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(criteriaOptionsToolbar)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(criteriaOptionsToolbar.snp.bottom).offset(12.5)
            make.right.left.bottom.equalToSuperview()
        }
        criteriaOptionsToolbar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.right.left.equalToSuperview().inset(10)
        }
    }
}
