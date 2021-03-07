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
    
    enum LayoutType {
        case small
        case large
    }
    
    private enum Constants {
        static let largeFontSize: CGFloat = 15
        static let smallFontSize: CGFloat = 10
        static let photoMarginLarge: CGFloat = 9
        static let photoMarginSmall: CGFloat = 5
        static let spaceBetweenPhotoInfoSmall: CGFloat = 2
        static let spaceBetweenPhotoInfoLarge: CGFloat = 12
        static let photoLeftMarginSmall: CGFloat = 1
        static let photoLeftMarginLarge: CGFloat = 15
        static let infoTopMarginSmall: CGFloat = 1
        static let infoTopMarginLarge: CGFloat = 12
    }
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private var name: String
    private var ocupation: String
    private var photo: String?
    private var layout: LayoutType = .small
    
    private var photoMargin: CGFloat {
        if layout == .small {
            return Constants.photoMarginSmall
        } else {
            return Constants.photoMarginLarge
        }
    }
    
    private var fontSize: CGFloat {
        if layout == .small {
            return Constants.smallFontSize
        }
        return Constants.largeFontSize
    }
    
    private var spaceBetweenPhotoInfo: CGFloat {
        if layout == .small {
            return Constants.spaceBetweenPhotoInfoSmall
        }
        return Constants.spaceBetweenPhotoInfoLarge
    }
    
    private var photoLeftMargin: CGFloat {
        if layout == .small {
            return Constants.photoLeftMarginSmall
        }
        return Constants.photoLeftMarginLarge
    }
    
    private var infoTopMargin: CGFloat {
        if layout == .small {
            return Constants.infoTopMarginSmall
        }
        return Constants.infoTopMarginLarge
    }
    
    init(frame: CGRect,
         name: String = .empty,
         ocupation: String = .empty,
         photo: String? = nil,
         layout: LayoutType = .small) {
        self.name = name
        self.ocupation = ocupation
        self.photo = photo
        self.layout = layout
        super.init(frame: frame)
        applyViewCode()
    }
    
    func setup(name: String,
               ocupation: String,
               photo: String) {
        self.name = name
        self.ocupation = ocupation
        self.photo = photo
        fillInformation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }
    
    private func fillInformation() {
        nameLbl.text = name
        ocupationLbl.text = ocupation
        guard let image = photo else { return }
        photoImageView.sd_setImage(with: URL(string: image), completed: nil)
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
            make.top.bottom.equalToSuperview().inset(photoMargin)
            make.left.equalToSuperview().inset(photoLeftMargin)
            make.width.equalTo(photoImageView.snp.height)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView).offset(infoTopMargin)
            make.left.equalTo(photoImageView.snp.right).offset(spaceBetweenPhotoInfo)
            make.right.equalToSuperview()
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        clipsToBounds = true
        backgroundColor = UIColor(rgb: 0xededed)
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0xe3eded).cgColor
        layer.cornerRadius = 4
        nameLbl.text = name
        ocupationLbl.text = ocupation
        nameLbl.font = ThemeFonts.RobotoBold(fontSize).rawValue
        ocupationLbl.font = ThemeFonts.RobotoRegular(fontSize).rawValue
        photoImageView.sd_setImage(with: URL(string: photo ?? .empty), completed: nil)
    }
}
