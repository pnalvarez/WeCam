//
//  OnGoingProjectInvitesView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProjectInvitesView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var modalAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var closeButton: DefaultCloseButton
    private unowned var searchTextField: UITextField
    private unowned var tableView: UITableView
    
    private lazy var projectTitleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = ProjectInvites.Constants.Fonts.projectTitleLbl
        view.textColor = ProjectInvites.Constants.Colors.projectTitleLbl
        view.numberOfLines = 0
        return view
    }()
    
    private var viewModel: ProjectInvites.Info.ViewModel.Project?
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         modalAlertView: ConfirmationAlertView,
         translucentView: UIView,
         closeButton: DefaultCloseButton,
         searchTextField: UITextField,
         tableView: UITableView) {
        self.activityView = activityView
        self.modalAlertView = modalAlertView
        self.translucentView = translucentView
        self.closeButton = closeButton
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
    
    func displayConfirmationView(withText text: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.modalAlertView.setupText(text)
            self.translucentView.isHidden = false
            self.modalAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.right.left.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = true
            self.modalAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.bottom)
                make.right.left.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
}

extension ProjectInvitesView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(projectTitleLbl)
        addSubview(closeButton)
        addSubview(searchTextField)
        addSubview(tableView)
        addSubview(activityView)
        addSubview(translucentView)
        addSubview(modalAlertView)
    }
    
    func setupConstraints() {
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(31)
        }
        projectTitleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.left.equalToSuperview().inset(46)
            make.width.equalTo(200)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleLbl.snp.bottom).offset(24)
            make.left.equalTo(projectTitleLbl)
            make.right.equalTo(closeButton.snp.right)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(26)
            make.left.right.bottom.equalToSuperview()
        }
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        modalAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(translucentView)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        projectTitleLbl.text = viewModel?.title
    }
}
