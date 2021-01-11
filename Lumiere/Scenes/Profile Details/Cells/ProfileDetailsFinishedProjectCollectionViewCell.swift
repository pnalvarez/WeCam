//
//  ProfileDetailsFinishedProjectCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/01/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileDetailsFinishedProjectCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var viewModel: ProfileDetails.Info.ViewModel.Project?
    
    func setup(viewModel: ProfileDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProfileDetailsFinishedProjectCollectionViewCell: ViewCodeProtocol {
    
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
        imageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
    }
}
