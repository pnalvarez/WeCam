//
//  FinishedProjectItemCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 27/12/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class FinishedProjectItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var viewModel: MainFeed.Info.ViewModel.FinishedProject?
    
    func setup(viewModel: MainFeed.Info.ViewModel.FinishedProject) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension FinishedProjectItemCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        imageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
    }
}
