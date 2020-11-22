//
//  FinishedProjectFeedTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class FinishedProjectFeedTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private weak var delegate: FinishedProjectFeedTableViewCellDelegate?
    private var viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed
    
    init(delegate: FinishedProjectFeedTableViewCellDelegate? = nil,
         viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: FinishedProjectFeedTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.finishedProjectsFeedCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: FinishedProjectFeedTableViewCell.self)
        cell.setup(viewModel: viewModel)
        return cell
    }
}
