//
//  ProfileSuggestionsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProfileSuggestionsView: BaseView {

    private unowned var optionsToolbar: WCOptionsToolbar
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
         optionsToolbar: WCOptionsToolbar,
         tableView: UITableView) {
        self.optionsToolbar = optionsToolbar
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
        addSubview(mainHeader)
        addSubview(mainLbl)
        addSubview(optionsToolbar)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        mainHeader.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        optionsToolbar.snp.makeConstraints { make in
            make.top.equalTo(mainLbl.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
        }
        mainLbl.snp.makeConstraints { make in
            make.top.equalTo(mainHeader.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(150)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(optionsToolbar.snp.bottom).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
