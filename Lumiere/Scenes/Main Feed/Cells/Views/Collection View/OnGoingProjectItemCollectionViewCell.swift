//
//  OnGoingProjectItemCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 27/12/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class OnGoingProjectItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.progressTintColor = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .gray
        return view
    }()
    
    private var viewModel: MainFeed.Info.ViewModel.OnGoingProject?
    
    func setup(viewModel: MainFeed.Info.ViewModel.OnGoingProject) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension OnGoingProjectItemCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(progressView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(84)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(5)
            make.centerX.equalTo(photoImageView)
            make.left.right.equalToSuperview().inset(5)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        clipsToBounds = true
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        progressView.progress = viewModel?.progress ?? 0.0
    }
}
