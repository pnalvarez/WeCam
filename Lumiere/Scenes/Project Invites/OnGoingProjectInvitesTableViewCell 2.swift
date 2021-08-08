//
//  OnGoingProjectInvitesTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

protocol OnGoingProjectInvitesTableViewCellDelegate: class {
    func didTapInteraction(index: Int)
}

class OnGoingProjectInvitesTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 42
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = OnGoingProjectInvites.Constants.Fonts.nameLbl
        view.textColor = OnGoingProjectInvites.Constants.Colors.nameLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = OnGoingProjectInvites.Constants.Fonts.ocupationLbl
        view.textColor = OnGoingProjectInvites.Constants.Colors.ocupationLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var interactButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        return view
    }()
    
    private weak var delegate: OnGoingProjectInvitesTableViewCellDelegate?
    private var index: Int?
    private var viewModel: OnGoingProjectInvites.Info.ViewModel.User?
    
    func setup(delegate: OnGoingProjectInvitesTableViewCellDelegate? = nil,
               index: Int,
               viewModel: OnGoingProjectInvites.Info.ViewModel.User) {
        self.delegate = delegate
        self.index = index
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func updateRelation(image: UIImage?) {
        interactButton.setImage(image, for: .normal)
    }
}

extension OnGoingProjectInvitesTableViewCell {
    
    @objc
    private func didTapInteraction() {
        delegate?.didTapInteraction(index: index ?? 0)
    }
}

extension OnGoingProjectInvitesTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
        addSubview(emailLbl)
        addSubview(interactButton)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(84)
        }
        interactButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLbl)
            make.height.width.equalTo(30)
            make.right.equalToSuperview().inset(30)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).offset(17)
            make.right.equalTo(interactButton.snp.left).offset(10)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.width.equalTo(220)
        }
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(ocupationLbl.snp.bottom)
            make.left.equalTo(ocupationLbl)
            make.right.equalToSuperview().inset(2)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
        emailLbl.attributedText = viewModel?.email
        photoImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        interactButton.setImage(viewModel?.relation, for: .normal)
    }
}
