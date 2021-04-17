//
//  SearchHeaderTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SearchHeaderTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private weak var delegate: SearchHeaderTableViewCellDelegate?
    
    init(delegate: SearchHeaderTableViewCellDelegate? = nil) {
        self.delegate = delegate
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: SearchHeaderTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.headerCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                                 type: SearchHeaderTableViewCell.self)
        cell.setup(delegate: delegate)
        return cell
    }
}
