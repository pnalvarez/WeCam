//
//  SearchResultsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SearchResultsView: BaseView {
    
    private unowned var resultTypesOptionsToolbar: WCOptionsToolbar
    private unowned var resultsQuantityLbl: UILabel
    private unowned var tableView: UITableView
    
    private lazy var headerImageView: WCHeaderView = {
        let view = WCHeaderView(frame: .zero)
        return view
    }()
    
    init(frame: CGRect,
         resultTypesOptionsToolbar: WCOptionsToolbar,
         resultsQuantityLbl: UILabel,
         tableView: UITableView) {
        self.resultTypesOptionsToolbar = resultTypesOptionsToolbar
        self.resultsQuantityLbl = resultsQuantityLbl
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(headerImageView)
        addSubview(resultTypesOptionsToolbar)
        addSubview(resultsQuantityLbl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        resultTypesOptionsToolbar.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(24)
            make.right.left.equalToSuperview().inset(10)
        }
        resultsQuantityLbl.snp.makeConstraints { make in
            make.top.equalTo(resultTypesOptionsToolbar.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(resultsQuantityLbl.snp.bottom).offset(18)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
