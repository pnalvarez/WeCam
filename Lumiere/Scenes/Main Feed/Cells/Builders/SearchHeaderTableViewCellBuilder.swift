//
//  SearchHeaderTableViewCellBuilder.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SearchHeaderTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(cellType: SearchHeaderTableViewCell.self)
    }
    
    func cellHeight() -> CGFloat {
        return MainFeed.Constants.Dimensions.Heighs.headerCell
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                                 type: SearchHeaderTableViewCell.self)
        cell.setup()
        return cell
    }
}
