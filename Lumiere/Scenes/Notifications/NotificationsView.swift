//
//  NotificationsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class NotificationsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var tableView: NotificationsTableView
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         tableView: NotificationsTableView) {
        self.activityView = activityView
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
        addSubview(tableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
