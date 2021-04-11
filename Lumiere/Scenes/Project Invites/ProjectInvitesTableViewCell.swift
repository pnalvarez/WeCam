//
//  OnGoingProjectInvitesTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProjectInvitesTableViewCellDelegate: class {
    func didTapInteraction(index: Int)
}

class ProjectInvitesTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = ProjectInvites.Constants.Fonts.nameLbl
        view.textColor = ProjectInvites.Constants.Colors.nameLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = ProjectInvites.Constants.Fonts.ocupationLbl
        view.textColor = ProjectInvites.Constants.Colors.ocupationLbl
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
    
    private weak var delegate: ProjectInvitesTableViewCellDelegate?
    private var index: Int?
    private var viewModel: ProjectInvites.Info.ViewModel.User?
    
    func setup(delegate: ProjectInvitesTableViewCellDelegate? = nil,
               index: Int,
               viewModel: ProjectInvites.Info.ViewModel.User) {
        self.delegate = delegate
        self.index = index
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func updateRelation(image: UIImage?) {
        interactButton.setImage(image, for: .normal)
    }
}

extension ProjectInvitesTableViewCell {
    
    @objc
    private func didTapInteraction() {
        delegate?.didTapInteraction(index: index ?? 0)
    }
}

extension ProjectInvitesTableViewCell: ViewCodeProtocol {
    
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
            make.width.equalTo(84)
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
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        interactButton.setImage(viewModel?.relation, for: .normal)
    }
}
