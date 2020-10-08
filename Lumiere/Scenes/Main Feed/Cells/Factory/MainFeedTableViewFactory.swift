//
//  MainFeedTableViewFactory.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class MainFeedTableViewFactory: TableViewFactory {
    
    private let tableView: UITableView
    var profileSuggestionsViewModel: MainFeed.Info.ViewModel.UpcomingProfiles?
    
    private weak var searchDelegate: SearchHeaderTableViewCellDelegate?
    private weak var profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate?
    
    init(tableView: UITableView,
         profileSuggestionsViewModel: MainFeed.Info.ViewModel.UpcomingProfiles? = nil,
         searchDelegate: SearchHeaderTableViewCellDelegate? = nil,
         profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil) {
        self.tableView = tableView
        self.profileSuggestionsViewModel = profileSuggestionsViewModel
        self.searchDelegate = searchDelegate
        self.profileSuggestionsDelegate = profileSuggestionsDelegate
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [headerSection]
    }
    
    private var headerSection: TableViewSectionProtocol {
        return BaseSection(builders: [SearchHeaderTableViewCellBuilder(delegate: searchDelegate),
                                      ProfileSuggestionsFeedTableViewCellBuilder(delegate: profileSuggestionsDelegate, viewModel: profileSuggestionsViewModel)],
                           tableView: tableView)
    }
}
