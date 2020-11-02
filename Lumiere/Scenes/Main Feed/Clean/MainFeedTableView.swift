//
//  MainFeedTableView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class MainFeedTableView: UITableView {
    
    private unowned var errorView: EmptyListView
    
    init(frame: CGRect,
         style: UITableView.Style = .plain,
         errorView: EmptyListView) {
        self.errorView = errorView
        super.init(frame: frame, style: style)
        separatorStyle = .none
        bounces = false
        alwaysBounceVertical = false
        backgroundColor = .white
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFeedTableView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(errorView)
    }
    
    func setupConstraints() {
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
