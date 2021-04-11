//
//  ProfileSuggestionsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProfileSuggestionsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var backButton: WCBackButton
    private unowned var filterButton: SelectionFilterView
    private unowned var optionsStackView: UIStackView
    private unowned var tableView: UITableView
    
    private lazy var mainHeader: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = ProfileSuggestions.Constants.Images.lumiere
        return view
    }()
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileSuggestions.Constants.Texts.mainLbl
        view.font = ProfileSuggestions.Constants.Fonts.mainLbl
        view.textColor = ProfileSuggestions.Constants.Colors.mainLbl
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         backButton: WCBackButton,
         filterButton: SelectionFilterView,
         optionsStackView: UIStackView,
         tableView: UITableView) {
        self.activityView = activityView
        self.backButton = backButton
        self.filterButton = filterButton
        self.optionsStackView = optionsStackView
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSuggestionsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(activityView)
        addSubview(backButton)
        addSubview(mainHeader)
        addSubview(mainLbl)
        addSubview(filterButton)
        addSubview(tableView)
        addSubview(optionsStackView)
    }
    
    func setupConstraints() {
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(7)
            make.left.equalToSuperview().inset(26)
            make.width.height.equalTo(31)
        }
        mainHeader.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        mainLbl.snp.makeConstraints { make in
            make.top.equalTo(mainHeader.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(150)
        }
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(mainLbl)
            make.left.equalTo(mainLbl.snp.right).offset(9)
            make.right.equalToSuperview().inset(11)
            make.height.equalTo(18)
        }
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom)
            make.centerX.equalTo(filterButton)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainLbl.snp.bottom).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
