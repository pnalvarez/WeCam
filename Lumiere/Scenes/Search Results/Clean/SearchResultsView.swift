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
    private unowned var searchTextField: UITextField
    private unowned var searchButton: UIButton
    private unowned var resultTypesSegmentedControl: UISegmentedControl
    private unowned var tableView: UITableView
    
    private lazy var headerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = SearchResults.Constants.Images.headerImageView
        return view
    }()
    
    private lazy var searchDivider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = SearchResults.Constants.Colors.dividerView
        return view
    }()
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         backButton: DefaultBackButton,
         searchTextField: UITextField,
         searchButton: UIButton,
         resultTypesSegmentedControl: UISegmentedControl,
         tableView: UITableView) {
        self.activityView = activityView
        self.backButton = backButton
        self.searchTextField = searchTextField
        self.searchButton = searchButton
        self.resultTypesSegmentedControl = resultTypesSegmentedControl
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
        searchTextField.addSubview(searchDivider)
        searchTextField.addSubview(searchButton)
        addSubview(searchTextField)
        addSubview(resultTypesSegmentedControl)
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
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(242)
            make.height.equalTo(18)
        }
        searchDivider.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(searchButton.snp.left)
            make.width.equalTo(1)
        }
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(2)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        resultTypesSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(32)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(resultTypesSegmentedControl.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
