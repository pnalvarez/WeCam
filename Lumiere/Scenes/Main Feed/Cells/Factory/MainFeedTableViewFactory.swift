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
    private weak var searchDelegate: SearchHeaderTableViewCellDelegate?
    
    init(tableView: UITableView,
         searchDelegate: SearchHeaderTableViewCellDelegate? = nil) {
        self.tableView = tableView
        self.searchDelegate = searchDelegate
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [headerSection]
    }
    
    private var headerSection: TableViewSectionProtocol {
        return BaseSection(builders: [SearchHeaderTableViewCellBuilder(delegate: searchDelegate)],
                           tableView: tableView)
    }
}
