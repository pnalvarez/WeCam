//
//  ProfileResultTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProfileResultTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private let viewModel: SearchResults.Info.ViewModel.Profile
    
    init(viewModel: SearchResults.Info.ViewModel.Profile) {
        self.viewModel = viewModel
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: ProfileResultTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return SearchResults.Constants.Dimensions.Heights.defaultCellHeight
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                                 type: ProfileResultTableViewCell.self)
        cell.setup(viewModel: viewModel)
        return cell
    }
}
