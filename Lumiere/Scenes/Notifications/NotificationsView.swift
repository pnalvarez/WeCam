//
//  NotificationsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

class NotificationsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var criteriaSegmentedControl: UISegmentedControl
    private unowned var tableView: NotificationsTableView
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         criteriaSegmentedControl: UISegmentedControl,
         tableView: NotificationsTableView) {
        self.activityView = activityView
        self.criteriaSegmentedControl = criteriaSegmentedControl
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
        addSubview(criteriaSegmentedControl)
        addSubview(tableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(criteriaSegmentedControl.snp.bottom).offset(12.5)
            make.right.left.bottom.equalToSuperview()
        }
        criteriaSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(32)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
