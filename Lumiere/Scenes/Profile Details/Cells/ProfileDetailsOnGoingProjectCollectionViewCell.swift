//
//  ProfileDetailsOnGoingProjectCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/01/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

class ProfileDetailsOnGoingProjectCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private var viewModel: ProfileDetails.Info.ViewModel.Project?
    
    func setup(viewModel: ProfileDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProfileDetailsOnGoingProjectCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        clipsToBounds = true
        imageView.setImage(withURL: viewModel?.image ?? .empty)
    }
}
