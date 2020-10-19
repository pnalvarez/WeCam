//
//  OnGoingProjectsFeedTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 17/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class OnGoingProjectsFeedTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProjects?
    private var criteriasViewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias?
    
    init(delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil,
         viewModel: MainFeed.Info.ViewModel.UpcomingProjects?,
         criteriasViewModel : MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias? = nil) {
        self.delegate = delegate
        self.viewModel = viewModel
        self.criteriasViewModel = criteriasViewModel
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
                   delegate: delegate,
                   criteriasViewModel: criteriasViewModel)
        return cell
    }
}
