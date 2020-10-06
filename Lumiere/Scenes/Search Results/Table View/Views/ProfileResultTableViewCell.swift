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
        view.clipsToBounds = true
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
    
    private lazy var dividerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = SearchResults.Constants.Colors.dividerView
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
        addSubview(dividerView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(56)
            make.left.equalToSuperview().inset(28)
        }
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(12)
            make.width.equalTo(177)
            make.top.equalTo(photoImageView)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.width.equalTo(nameLbl)
            make.left.equalTo(nameLbl)
        }
        dividerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    func configureViews() {
        backgroundColor = SearchResults.Constants.Colors.background
        photoImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
    }
}
