//
//  OnGoingProjectInvitesView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProjectInvitesView: BaseView {
    
    private unowned var searchTextField: WCDataTextField
    private unowned var tableView: UITableView
    
    private lazy var projectTitleLbl: WCUILabelRobotoRegular16Gray = {
        let view = WCUILabelRobotoRegular16Gray(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    private var viewModel: ProjectInvites.Info.ViewModel.Project?
    
    init(frame: CGRect,
         searchTextField: WCDataTextField,
         tableView: UITableView) {
        self.searchTextField = searchTextField
        self.tableView = tableView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ProjectInvites.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func hideHeaderElements() {
        projectTitleLbl.isHidden = true
        searchTextField.isHidden = true
    }
}

extension ProjectInvitesView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(projectTitleLbl)
        addSubview(searchTextField)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        projectTitleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(16)
            make.width.equalTo(200)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleLbl.snp.bottom).offset(24)
            make.left.equalTo(projectTitleLbl)
            make.right.equalToSuperview().inset(64)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(26)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        projectTitleLbl.text = viewModel?.title
    }
}
