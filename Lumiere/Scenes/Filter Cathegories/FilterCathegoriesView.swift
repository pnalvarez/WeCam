//
//  FilterCathegoriesView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 17/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class FilterCathegoriesView: BaseView {

    private unowned var cathegoryListView: WCCathegoryListView
    private unowned var filterButton: WCPrimaryActionButton
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.attributedText = NSAttributedString(string: FilterCathegories.Constants.Texts.titleLbl, attributes: [NSAttributedString.Key.foregroundColor: FilterCathegories.Constants.Colors.titleLbl, NSAttributedString.Key.font: FilterCathegories.Constants.Fonts.titleLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        view.textAlignment = .center
        return view
    }()
    
    init(frame: CGRect,
         cathegoryListView: WCCathegoryListView,
         filterButton: WCPrimaryActionButton) {
        self.cathegoryListView = cathegoryListView
        self.filterButton = filterButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterCathegoriesView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(titleLbl)
        addSubview(cathegoryListView)
        addSubview(filterButton)
    }
    
    func setupConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(19)
            make.centerX.equalToSuperview()
            make.width.equalTo(88)
        }
        cathegoryListView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(51)
            make.left.right.equalToSuperview()
        }
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(cathegoryListView.snp.bottom).offset(84)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
        }
    }
}
