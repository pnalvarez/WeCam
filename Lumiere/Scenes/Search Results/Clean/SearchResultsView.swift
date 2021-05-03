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
    
    private unowned var resultTypesSegmentedControl: UISegmentedControl
    private unowned var resultsQuantityLbl: UILabel
    private unowned var tableView: UITableView
    
    private lazy var headerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = SearchResults.Constants.Images.headerImageView
        return view
    }()
    
    init(frame: CGRect,
         resultTypesSegmentedControl: UISegmentedControl,
         resultsQuantityLbl: UILabel,
         tableView: UITableView) {
        self.resultTypesSegmentedControl = resultTypesSegmentedControl
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
        addSubview(resultTypesSegmentedControl)
        addSubview(resultsQuantityLbl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        resultTypesSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(15)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(32)
        }
        resultsQuantityLbl.snp.makeConstraints { make in
            make.top.equalTo(resultTypesSegmentedControl.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(resultsQuantityLbl.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
