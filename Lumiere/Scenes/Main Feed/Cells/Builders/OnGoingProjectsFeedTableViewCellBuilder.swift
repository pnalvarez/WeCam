//
//  OnGoingProjectsFeedTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 17/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class OnGoingProjectsFeedTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProjects?
    
    init(delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil,
         viewModel: MainFeed.Info.ViewModel.UpcomingProjects?) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: OnGoingProjectsFeedTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.ongoingProjectsFeedCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: OnGoingProjectsFeedTableViewCell.self)
        cell.setup(viewModel: viewModel,
                   delegate: delegate)
        return cell
    }
}
