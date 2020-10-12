//
//  RecentSearchTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 06/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = MainFeed.Constants.Colors.recentSearchTitle
        view.font = MainFeed.Constants.Fonts.recentSearchTitle
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private var viewModel: MainFeed.Info.ViewModel.RecentSearch?
    
    func setup(viewModel: MainFeed.Info.ViewModel.RecentSearch) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension RecentSearchTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(titleLbl)
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}
