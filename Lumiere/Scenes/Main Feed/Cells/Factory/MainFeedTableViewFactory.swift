//
//  MainFeedTableViewFactory.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class MainFeedTableViewFactory: TableViewFactory {
    
    private let tableView: UITableView
    var viewModel: MainFeed.Info.ViewModel.UpcomingFeedData?
    
    private weak var searchDelegate: SearchHeaderTableViewCellDelegate?
    private weak var profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate?
    private weak var ongoingProjectsFeedDelegate: OnGoingProjectsFeedTableViewCellDelegate?
    private weak var finishedProjectsFeedDelegate: FinishedProjectFeedTableViewCellDelegate?
    
    init(tableView: UITableView,
         viewModel: MainFeed.Info.ViewModel.UpcomingFeedData? = nil,
         searchDelegate: SearchHeaderTableViewCellDelegate? = nil,
         profileSuggestionsDelegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil,
         ongoingProjectsFeedDelegate: OnGoingProjectsFeedTableViewCellDelegate? = nil,
         finishedProjectsFeedDelegate: FinishedProjectFeedTableViewCellDelegate? = nil) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.searchDelegate = searchDelegate
        self.profileSuggestionsDelegate = profileSuggestionsDelegate
        self.ongoingProjectsFeedDelegate = ongoingProjectsFeedDelegate
        self.finishedProjectsFeedDelegate = finishedProjectsFeedDelegate
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [firstSection, finishedProjectsSection()]
    }
    
    private var firstSection: TableViewSectionProtocol {
        let section = BaseSection(tableView: tableView)
        section.builders.append(headerBuilder)
        section.builders.append(profileSuggestionsBuilder)
        if shouldHaveOngoingProjectsFeed() {
            section.builders.append(ongoingProjectsFeedBuilder)
        }
        return section
    }
    
    private var headerBuilder: TableViewCellBuilderProtocol {
        return SearchHeaderTableViewCellBuilder(delegate: searchDelegate)
    }
    
    private var profileSuggestionsBuilder: TableViewCellBuilderProtocol {
        return ProfileSuggestionsFeedTableViewCellBuilder(delegate: profileSuggestionsDelegate,
                                                          viewModel: viewModel?.suggestedProfiles)
    }
    
    private var ongoingProjectsFeedBuilder: TableViewCellBuilderProtocol {
        return OnGoingProjectsFeedTableViewCellBuilder(delegate: ongoingProjectsFeedDelegate,
                                                       viewModel: viewModel?.ongoingProjects)
    }
    
    private var finishedProjectsFeedsBuilder: [TableViewCellBuilderProtocol] {
        var builders = [TableViewCellBuilderProtocol]()
        guard let feeds = viewModel?.finishedProjects.feeds else { return .empty }
        for index in 0..<feeds.count {
            if !feeds[index].projects.isEmpty {
                builders.append(FinishedProjectFeedTableViewCellBuilder(delegate: finishedProjectsFeedDelegate, index: index, viewModel: feeds[index]))
            }
        }
        return builders
    }
    
    private func finishedProjectsSection() -> TableViewSectionProtocol {
        return BaseSection(builders: finishedProjectsFeedsBuilder, tableView: tableView)
    }
    
    private func shouldHaveOngoingProjectsFeed() -> Bool {
        return !(viewModel?.ongoingProjects.projects.isEmpty ?? false)
    }
}
