//
//  RecentSearchTableViewCell.swift
//  WeCam
//
//  Created by Pedro Alvarez on 10/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    private lazy var searchDisplayView: WCSearchDisplayView = {
        let view = WCSearchDisplayView(frame: .zero)
        return view
    }()
    
    private var viewModel: RecentSearch.Info.ViewModel.Search? {
        didSet {
            searchDisplayView.setup(name: viewModel?.name ?? .empty, imageURL: viewModel?.image ?? .empty, secondaryInfo: viewModel?.secondaryInfo ?? .empty)
        }
    }
    
    func setup(viewModel: RecentSearch.Info.ViewModel.Search) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension RecentSearchTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(searchDisplayView)
    }
    
    func setupConstraints() {
        searchDisplayView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
