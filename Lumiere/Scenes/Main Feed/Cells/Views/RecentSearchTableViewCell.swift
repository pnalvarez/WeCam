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
        photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.height.width.equalTo(28)
            make.centerY.equalToSuperview()
        }
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(10)
            make.width.equalTo(100)
            make.centerY.equalTo(photoImageView)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .gray
        photoImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        titleLbl.text = viewModel?.title
    }
}
