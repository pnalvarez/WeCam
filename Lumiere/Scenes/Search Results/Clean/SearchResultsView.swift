//
//  SearchResultsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SearchResultsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var backButton: DefaultBackButton
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
         activityView: UIActivityIndicatorView,
         backButton: DefaultBackButton,
         resultTypesSegmentedControl: UISegmentedControl,
         resultsQuantityLbl: UILabel,
         tableView: UITableView) {
        self.activityView = activityView
        self.backButton = backButton
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
        addSubview(backButton)
        addSubview(headerImageView)
        addSubview(resultTypesSegmentedControl)
        addSubview(resultsQuantityLbl)
        addSubview(tableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(7)
            make.left.equalToSuperview().inset(26)
            make.width.height.equalTo(31)
        }
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
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
