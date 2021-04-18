//
//  FilterCathegoriesView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 17/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class FilterCathegoriesView: UIView {

    private unowned var closeButton: WCCloseButton
    private unowned var cathegoryListView: WCCathegoryListView
    private unowned var filterButton: WCActionButton
    private unowned var activityView: UIActivityIndicatorView
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.attributedText = NSAttributedString(string: FilterCathegories.Constants.Texts.titleLbl, attributes: [NSAttributedString.Key.foregroundColor: FilterCathegories.Constants.Colors.titleLbl, NSAttributedString.Key.font: FilterCathegories.Constants.Fonts.titleLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        view.textAlignment = .center
        return view
    }()
    
    init(frame: CGRect,
         closeButton: WCCloseButton,
         cathegoryListView: WCCathegoryListView,
         filterButton: WCActionButton,
         activityView: UIActivityIndicatorView) {
        self.closeButton = closeButton
        self.cathegoryListView = cathegoryListView
        self.filterButton = filterButton
        self.activityView = activityView
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
        addSubview(closeButton)
        addSubview(cathegoryListView)
        addSubview(filterButton)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(19)
            make.centerX.equalToSuperview()
            make.width.equalTo(88)
        }
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLbl)
            make.right.equalToSuperview().inset(38)
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
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
