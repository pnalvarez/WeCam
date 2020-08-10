//
//  ConnectionsListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ConnectionsListView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var tableView: UITableView
    
    private lazy var nameHeaderLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ConnectionsList.Constants.Fonts.nameHeaderLbl
        view.textColor = ConnectionsList.Constants.Colors.nameHeaderLbl
        return view
    }()
    
    private var viewModel: ConnectionsList.Info.ViewModel.CurrentUser?
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         tableView: UITableView) {
        self.activityView = activityView
        self.tableView = tableView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ConnectionsList.Info.ViewModel.CurrentUser) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ConnectionsListView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(nameHeaderLbl)
        addSubview(tableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        nameHeaderLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(107)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameHeaderLbl.snp.bottom).offset(47)
            make.bottom.left.right.equalToSuperview()
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = ConnectionsList.Constants.Colors.background
        nameHeaderLbl.text = viewModel?.name
    }
}
