//
//  ProfileSuggestionCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 27/12/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

class ProfileSuggestionCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.font = ThemeFonts.RobotoBold(10).rawValue
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.font = ThemeFonts.RobotoRegular(10).rawValue
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()

    private var viewModel: MainFeed.Info.ViewModel.ProfileSuggestion?
    
    func setup(viewModel: MainFeed.Info.ViewModel.ProfileSuggestion?) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProfileSuggestionCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.left.equalToSuperview().inset(6)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView)
            make.width.equalTo(86)
            make.left.equalTo(photoImageView.snp.right).offset(4)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.width.equalTo(nameLbl)
        }
    }
    
    func configureViews() {
        backgroundColor = UIColor(rgb: 0xededed).withAlphaComponent(0.6)
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0xe5dfdf).cgColor
        clipsToBounds = true
        
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
    }
}
