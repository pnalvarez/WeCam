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
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [headerSection]
    }
    
    private var headerSection: TableViewSectionProtocol {
        return BaseSection(builders: [SearchHeaderTableViewCellBuilder()],
                           tableView: tableView)
    }
}
