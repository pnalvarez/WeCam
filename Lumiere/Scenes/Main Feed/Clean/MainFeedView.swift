//
//  MainFeedView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 14/08/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class MainFeedView: BaseView {
    
    private unowned var tableView: MainFeedTableView
    
    init(frame: CGRect,
         tableView: MainFeedTableView) {
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFeedView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
