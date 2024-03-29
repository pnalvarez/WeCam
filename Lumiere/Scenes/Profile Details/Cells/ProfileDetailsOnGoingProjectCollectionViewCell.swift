//
//  ProfileDetailsOnGoingProjectCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/01/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileDetailsOnGoingProjectCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 42
        view.clipsToBounds = true
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
        imageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
    }
}
