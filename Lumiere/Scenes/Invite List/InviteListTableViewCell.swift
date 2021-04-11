//
//  InviteListTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

protocol InviteListTableViewCellDelegate: class {
    func didSelectCell(index: Int)
}

class InviteListTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InviteList.Constants.Colors.nameLblCell
        view.font = InviteList.Constants.Fonts.nameLblCell
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InviteList.Constants.Colors.ocupationLblCell
        view.font = InviteList.Constants.Fonts.ocupationLblCell
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InviteList.Constants.Colors.emailLblCell
        view.font = InviteList.Constants.Fonts.emailLblCell
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var checkButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var viewModel: InviteList.Info.ViewModel.User?
    private var index: Int?
    private weak var delegate: InviteListTableViewCellDelegate?
    
    func setup(viewModel: InviteList.Info.ViewModel.User,
               index: Int,
               delegate: InviteListTableViewCellDelegate? = nil) {
        self.viewModel = viewModel
        self.index = index
        self.delegate = delegate
        applyViewCode()
    }
}

extension InviteListTableViewCell {
    
    @objc
    private func didTapCheckButton() {
        guard let index = index else { return }
        delegate?.didSelectCell(index: index)
    }
}

extension InviteListTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
        addSubview(emailLbl)
        addSubview(checkButton)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(96)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).offset(12)
            make.right.equalTo(checkButton.snp.left).offset(-2)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(ocupationLbl.snp.bottom)
            make.left.equalTo(ocupationLbl)
            make.right.equalToSuperview()
        }
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(nameLbl)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(31)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
        emailLbl.text = viewModel?.email
        
        guard let inviting = viewModel?.inviting,
            let image = viewModel?.image else { return }
        
        if inviting {
            checkButton.setImage(InviteList.Constants.Images.checkButtonSelected, for: .normal)
        } else {
            checkButton.setImage(InviteList.Constants.Images.checkButtonUnselected, for: .normal)
        }
        photoImageView.setImage(withURL: image)
    }
}
