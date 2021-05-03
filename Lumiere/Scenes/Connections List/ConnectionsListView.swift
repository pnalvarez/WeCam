//
//  ConnectionsListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ConnectionsListView: BaseView {
    
    private unowned var tableView: UITableView
    
    private lazy var nameHeaderLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ConnectionsList.Constants.Fonts.nameHeaderLbl
        view.textColor = ConnectionsList.Constants.Colors.nameHeaderLbl
        return view
    }()
    
    private var viewModel: ConnectionsList.Info.ViewModel.CurrentUser?
    
    init(frame: CGRect,
         tableView: UITableView) {
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
    }
    
    func setupConstraints() {
        nameHeaderLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(44)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.width.equalTo(150)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameHeaderLbl.snp.bottom).offset(47)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = ConnectionsList.Constants.Colors.background
        nameHeaderLbl.text = viewModel?.name
    }
}
