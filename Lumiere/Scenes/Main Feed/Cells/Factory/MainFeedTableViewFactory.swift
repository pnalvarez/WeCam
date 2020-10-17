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
    var ongoingProjectsViewModel: MainFeed.Info.ViewModel.UpcomingProjects?
    
    private weak var searchDelegate: SearchHeaderTableViewCellDelegate?
    private weak var profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate?
    private weak var ongoingProjectsFeedDelegate: OnGoingProjectsFeedTableViewCellDelegate?
    
    init(tableView: UITableView,
         profileSuggestionsViewModel: MainFeed.Info.ViewModel.UpcomingProfiles? = nil,
         ongoingProjectsViewModel: MainFeed.Info.ViewModel.UpcomingProjects? = nil,
         searchDelegate: SearchHeaderTableViewCellDelegate? = nil,
         profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil,
         ongoingProjectsFeedDelegate: OnGoingProjectsFeedTableViewCellDelegate? = nil) {
        self.tableView = tableView
        self.profileSuggestionsViewModel = profileSuggestionsViewModel
        self.ongoingProjectsViewModel = ongoingProjectsViewModel
        self.searchDelegate = searchDelegate
        self.profileSuggestionsDelegate = profileSuggestionsDelegate
        self.ongoingProjectsFeedDelegate = ongoingProjectsFeedDelegate
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [firstSection]
    }
    
    private var firstSection: TableViewSectionProtocol {
        return BaseSection(builders: [headerBuilder,
                                      profileSuggestionsBuilder,
                                      ongoingProjectsFeedBuilder],
                           tableView: tableView)
    }
    
    private var headerBuilder: TableViewCellBuilderProtocol {
        return SearchHeaderTableViewCellBuilder(delegate: searchDelegate)
    }
    
    private var profileSuggestionsBuilder: TableViewCellBuilderProtocol {
        return ProfileSuggestionsFeedTableViewCellBuilder(delegate: profileSuggestionsDelegate,
                                                          viewModel: profileSuggestionsViewModel)
    }
    
    private var ongoingProjectsFeedBuilder: TableViewCellBuilderProtocol {
        return OnGoingProjectsFeedTableViewCellBuilder(delegate: ongoingProjectsFeedDelegate,
                                                       viewModel: ongoingProjectsViewModel)
    }
}
