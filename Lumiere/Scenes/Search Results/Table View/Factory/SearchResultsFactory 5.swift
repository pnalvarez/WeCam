//
//  SearchResultsFactory.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SearchResultsFactory: TableViewFactory {
    
    var viewModel: SearchResults.Info.ViewModel.UpcomingResults
    private var tableView: UITableView
    
    init(viewModel: SearchResults.Info.ViewModel.UpcomingResults = SearchResults.Info.ViewModel.UpcomingResults(users: .empty, projects: .empty),
         tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [mainSection]
    }
    
    private var mainSection: TableViewSectionProtocol {
        var builders = [TableViewCellBuilderProtocol]()
        let userBuilders = viewModel.users.map({ return ProfileResultTableViewCellBuilder(viewModel: $0)})
        let profileBuilders = viewModel.projects.map({ OnGoingProjectResultTableViewCellBuilder(viewModel: $0)})
        builders.append(contentsOf: userBuilders)
        builders.append(contentsOf: profileBuilders)
        return BaseSection(builders: builders,
                           tableView: tableView)
    }
}
