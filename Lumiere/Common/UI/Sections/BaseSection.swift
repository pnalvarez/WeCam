//
//  BaseSection.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class BaseSection: TableViewSectionProtocol {
    
    var builders: [TableViewCellBuilderProtocol]
    
    init(builders: [TableViewCellBuilderProtocol]) {
        self.builders = builders
    }
    
    func heightForHeader() -> CGFloat {
        return 0
    }
    
    func headerView() -> UIView? {
        return nil
    }
    
    func numberOfRows() -> Int {
        return builders.count
    }
    
    func cellHeightFor(indexPath: IndexPath) -> CGFloat {
        return builders[indexPath.row].cellHeight()
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        return builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView)
    }
}
