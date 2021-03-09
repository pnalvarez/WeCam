//
//  TeamMemberCollectionViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class TeamMemberCollectionViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(rgb: 0xededed)
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor(rgb: 0xe5dfdf).cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = .black
        view.font = ThemeFonts.RobotoBold(10).rawValue
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .black
        view.font = ThemeFonts.RobotoRegular(10).rawValue
        return view
    }()
    
    private var name: String?
    private var jobDescription: String?
    private var image: String?
    
    func setup(name: String,
               jobDescription: String,
               image: String?) {
        self.name = name
        self.jobDescription = jobDescription
        self.image = image
        applyViewCode()
    }
}

extension TeamMemberCollectionViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        containerView.addSubview(imageView)
        containerView.addSubview(nameLbl)
        containerView.addSubview(ocupationLbl)
        addSubview(containerView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(2)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(36)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).inset(2)
            make.right.equalToSuperview()
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        nameLbl.text = name
        ocupationLbl.text = jobDescription
        imageView.sd_setImage(with: URL(string: image ?? .empty), completed: nil)
    }
}
