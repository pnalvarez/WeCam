//
//  UserDisplayView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 25/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

class UserDisplayView: UIView {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 17
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.font = ThemeFonts.RobotoBold(10).rawValue
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.font = ThemeFonts.RobotoRegular(10).rawValue
        view.numberOfLines = 0
        return view
    }()
    
    private var name: String
    private var ocupation: String
    private var photo: String?
    
    init(frame: CGRect,
         name: String,
         ocupation: String,
         photo: String?) {
        self.name = name
        self.ocupation = ocupation
        self.photo = photo
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserDisplayView: ViewCodeProtocol {
     
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(5)
            make.height.width.equalTo(34)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.equalTo(photoImageView.snp.right).offset(2)
            make.right.equalToSuperview()
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = UIColor(rgb: 0xededed)
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0xe3eded).cgColor
        layer.cornerRadius = 4
        nameLbl.text = name
        ocupationLbl.text = ocupation
        guard let image = photo else { return }
        photoImageView.sd_setImage(with: URL(string: image), completed: nil)
    }
}
