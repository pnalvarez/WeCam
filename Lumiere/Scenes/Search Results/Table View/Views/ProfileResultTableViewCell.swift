//
//  SearchResultsTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileResultTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 28
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.nameLbl
        view.font = SearchResults.Constants.Fonts.nameLbl
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.ocupationLbl
        view.font = SearchResults.Constants.Fonts.ocupationLbl
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private var viewModel: SearchResults.Info.ViewModel.Profile?
    
    func setup(viewModel: SearchResults.Info.ViewModel.Profile) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProfileResultTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = SearchResults.Constants.Colors.background
    }
}
