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
    
    private unowned var searchTextField: UITextField
    private unowned var tableView: UITableView
    private unowned var translucentView: UIView
    private unowned var modalAlert: ConfirmationAlertView
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = InviteProfileToProjects.Constants.Colors.mainLbl
        view.font = InviteProfileToProjects.Constants.Fonts.mainLbl
        view.text = InviteProfileToProjects.Constants.Texts.mainLbl
        return view
    }()
    
    init(frame: CGRect,
         searchTextField: UITextField,
         tableView: UITableView,
         translucentView: UIView,
         modalAlert: ConfirmationAlertView) {
        self.searchTextField = searchTextField
        self.tableView = tableView
        self.translucentView = translucentView
        self.modalAlert = modalAlert
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayConfirmationAlert(withText text: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = false
            self.modalAlert.setupText(text)
            self.modalAlert.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationAlert() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = true
            self.modalAlert.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
}

extension InviteProfileToProjectsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(mainLbl)
        addSubview(searchTextField)
        addSubview(tableView)
        addSubview(translucentView)
        addSubview(modalAlert)
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
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        modalAlert.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(translucentView)
        }
    }
}
