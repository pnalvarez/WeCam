//
//  ProfileSuggestionsFeedTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 07/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProfileSuggestionsFeedTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private weak var delegate: ProfileSuggestionsFeedTableViewCellDelegate?
    private let viewModel: MainFeed.Info.ViewModel.UpcomingProfiles?
    
    init(delegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil,
         viewModel: MainFeed.Info.ViewModel.UpcomingProfiles?) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: ProfileSuggestionsFeedTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.profileSuggestionsCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: ProfileSuggestionsFeedTableViewCell.self)
        cell.setup(delegate: delegate, viewModel: viewModel)
        return cell
    }
}
