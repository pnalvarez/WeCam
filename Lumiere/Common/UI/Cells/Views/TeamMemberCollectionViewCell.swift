//
//  TeamMemberCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class TeamMemberCollectionViewCell: UICollectionViewCell {
    
    private lazy var pictureImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var nameLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var jobLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private var viewModel: TeamMemberViewModel?
    
    func setup(viewModel: TeamMemberViewModel) {
        self.viewModel = viewModel
        applyViewCode()
    }
    
}

extension TeamMemberCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(pictureImageView)
        addSubview(nameLbl)
        addSubview(jobLbl)
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
            make.height.width.equalTo(28)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.left.equalTo(pictureImageView.snp.right).offset(7)
            make.right.equalToSuperview()
        }
        jobLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.image = viewModel?.image
        
        nameLbl.text = viewModel?.name
        nameLbl.textAlignment = .center
        nameLbl.numberOfLines = 0
        nameLbl.font = themefon
    }
}
