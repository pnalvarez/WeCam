//
//  BaseSection.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class BaseSection: TableViewSectionProtocol {
    
    var builders: [TableViewCellBuilderProtocol] {
        didSet {
            registerCells(in: tableView)
        }
    }
    
    private var tableView: UITableView
    
    init(builders: [TableViewCellBuilderProtocol] = .empty,
         tableView: UITableView) {
        self.builders = builders
        self.tableView = tableView
        registerCells(in: tableView)
    }
    
    private func registerCells(in tableView: UITableView) {
        for builder in builders {
            builder.registerCell(in: tableView)
        }
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
