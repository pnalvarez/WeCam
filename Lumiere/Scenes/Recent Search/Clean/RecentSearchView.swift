//
//  RecentSearchView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 10/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class RecentSearchView: UIView {
    
    private lazy var headerView: WCHeaderView = {
        let view = WCHeaderView(frame: .zero)
        return view
    }()
    
    private lazy var searchLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = RecentSearch.Constants.Texts.searchLbl
        view.font = RecentSearch.Constants.Fonts.searchLbl
        view.textColor = RecentSearch.Constants.Colors.searchLbl
        view.textAlignment = .left
        return view
    }()
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var backButton: WCBackButton
    private unowned var searchTextField: WCSearchTextField
    private unowned var resultsTableView: UITableView
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         backButton: WCBackButton,
         searchTextField: WCSearchTextField,
         resultsTableView: UITableView) {
        self.activityView = activityView
        self.backButton = backButton
        self.searchTextField = searchTextField
        self.resultsTableView = resultsTableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension RecentSearchView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(headerView)
        addSubview(searchTextField)
        addSubview(searchLbl)
        addSubview(resultsTableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(7)
            make.left.equalToSuperview().inset(28)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(242)
            make.height.equalTo(18)
        }
        searchLbl.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(28)
            make.width.equalTo(150)
        }
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchLbl.snp.bottom).offset(22)
            make.left.right.bottom.equalToSuperview()
        }
//        activityView.snp.makeConstraints { make in
//            make.edges.equalTo(resultsTableView)
//        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
