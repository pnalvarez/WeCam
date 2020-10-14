//
//  RecentSearchTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 07/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class RecentSearchTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private let viewModel: MainFeed.Info.ViewModel.RecentSearch
    
    init(viewModel: MainFeed.Info.ViewModel.RecentSearch) {
        self.viewModel = viewModel
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: RecentSearchTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.recentSearchCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: RecentSearchTableViewCell.self)
        cell.setup(viewModel: viewModel)
        return cell
    }
}
