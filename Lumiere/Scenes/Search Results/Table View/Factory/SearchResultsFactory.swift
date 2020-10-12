//
//  SearchResultsFactory.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SearchResultsFactory: TableViewFactory {
    
    var selectedType: SearchResults.Info.ViewModel.SelectedType
    var viewModel: SearchResults.Info.ViewModel.UpcomingResults
    private var tableView: UITableView
    
    init(selectedType: SearchResults.Info.ViewModel.SelectedType = .profile,
         viewModel: SearchResults.Info.ViewModel.UpcomingResults = SearchResults.Info.ViewModel.UpcomingResults(users: .empty, projects: .empty),
         tableView: UITableView) {
        self.selectedType = selectedType
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [mainSection]
    }
    
    private var mainSection: TableViewSectionProtocol {
        var builders = [TableViewCellBuilderProtocol]()
        switch selectedType {
        case .profile:
            builders = viewModel.users.map({ return ProfileResultTableViewCellBuilder(viewModel: $0)})
        case .project:
            builders = viewModel.projects.map({ OnGoingProjectResultTableViewCellBuilder(viewModel: $0)})
        }
//        let userBuilders = viewModel.users.map({ return ProfileResultTableViewCellBuilder(viewModel: $0)})
//        let profileBuilders = viewModel.projects.map({ OnGoingProjectResultTableViewCellBuilder(viewModel: $0)})
//        builders.append(contentsOf: userBuilders)
//        builders.append(contentsOf: profileBuilders)
        return BaseSection(builders: builders,
                           tableView: tableView)
    }
}
