//
//  OnGoingProjectResultTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class OnGoingProjectResultTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.titleLbl
        view.font = SearchResults.Constants.Fonts.titleLbl
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var cathegoriesLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.cathegoriesLbl
        view.font = SearchResults.Constants.Fonts.cathegoriesLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var progressLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.progressLbl
        view.font = SearchResults.Constants.Fonts.progressLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = SearchResults.Constants.Colors.dividerView
        return view
    }()
    
    private var viewModel: SearchResults.Info.ViewModel.Project?
    
    func setup(viewModel: SearchResults.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension OnGoingProjectResultTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(titleLbl)
        addSubview(cathegoriesLbl)
        addSubview(progressLbl)
        addSubview(dividerView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.left.equalToSuperview().inset(28)
        }
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(12)
            make.width.equalTo(177)
            make.top.equalTo(photoImageView)
        }
        cathegoriesLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom)
            make.width.equalTo(titleLbl)
            make.left.equalTo(titleLbl)
        }
        progressLbl.snp.makeConstraints { make in
            make.top.equalTo(cathegoriesLbl.snp.bottom)
            make.left.equalTo(cathegoriesLbl)
            make.width.equalTo(cathegoriesLbl)
        }
        dividerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    func configureViews() {
        backgroundColor = SearchResults.Constants.Colors.resultBackground
        selectionStyle = .none
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        titleLbl.text = viewModel?.title
        cathegoriesLbl.text = viewModel?.cathegories
        progressLbl.text = viewModel?.progress
    }
}
