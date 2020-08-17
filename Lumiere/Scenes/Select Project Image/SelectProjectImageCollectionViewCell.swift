//
//  SelectProjectImageCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SelectProjectImageCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var viewModel: SelectProjectImage.Info.ViewModel.Image?

    func setup(viewModel: SelectProjectImage.Info.ViewModel.Image) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension SelectProjectImageCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        imageView.image = viewModel?.image
    }
}
