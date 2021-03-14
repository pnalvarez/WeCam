//
//  RecentSearchTableViewCell.swift
//  WeCam
//
//  Created by Pedro Alvarez on 10/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    private lazy var userDisplayView: UserDisplayView = {
        let view = UserDisplayView(frame: .zero)
        return view
    }()
    
    private var viewModel: RecentSearch.Info.ViewModel.Search? {
        didSet {
            userDisplayView.setup(name: viewModel?.name ?? .empty,
                                  ocupation: viewModel?.secondaryInfo ?? .empty,
                                  photo: viewModel?.image ?? .empty)
        }
    }
    
    func setup(viewModel: RecentSearch.Info.ViewModel.Search) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension RecentSearchTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(userDisplayView)
    }
    
    func setupConstraints() {
        userDisplayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
