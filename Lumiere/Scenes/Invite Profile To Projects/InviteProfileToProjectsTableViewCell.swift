//
//  InviteProfileToProjectsTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

protocol InviteProfileToProjectsTableViewCellDelegate: class {
    func didTapInteraction(index: Int)
}

class InviteProfileToProjectsTableViewCell: UITableViewCell {
    
    private lazy var projectImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 42
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.textColor = InviteProfileToProjects.Constants.Colors.nameLbl
        view.font = InviteProfileToProjects.Constants.Fonts.nameLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var cathegoriesLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var progressLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.textColor = InviteProfileToProjects.Constants.Colors.progressLbl
        view.font = InviteProfileToProjects.Constants.Fonts.progressLbl
        return view
    }()
    
    private lazy var interactionButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        return view
    }()
    
    private weak var delegate: InviteProfileToProjectsTableViewCellDelegate?
    private var index: Int?
    private var viewModel: InviteProfileToProjects.Info.ViewModel.Project?
    
    func setup(delegate: InviteProfileToProjectsTableViewCellDelegate,
               index: Int,
               viewModel: InviteProfileToProjects.Info.ViewModel.Project) {
        self.delegate = delegate
        self.index = index
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func updateRelation(relation: UIImage?) {
        interactionButton.setImage(relation, for: .normal)
    }
}

extension InviteProfileToProjectsTableViewCell {
    
    @objc
    private func didTapInteraction() {
        delegate?.didTapInteraction(index: index ?? 0)
    }
}

extension InviteProfileToProjectsTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(projectImageView)
        addSubview(nameLbl)
        addSubview(cathegoriesLbl)
        addSubview(progressLbl)
        addSubview(interactionButton)
    }
    
    func setupConstraints() {
        projectImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(26)
            make.height.width.equalTo(84)
        }
        interactionButton.snp.makeConstraints { make in
            make.top.equalTo(projectImageView)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(30)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(projectImageView).offset(4)
            make.left.equalTo(projectImageView.snp.right).offset(17)
            make.right.equalTo(interactionButton.snp.left).offset(5)
        }
        cathegoriesLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
        progressLbl.snp.makeConstraints { make in
            make.top.equalTo(cathegoriesLbl.snp.bottom).offset(6)
            make.left.right.equalTo(cathegoriesLbl)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        projectImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        nameLbl.text = viewModel?.name
        cathegoriesLbl.attributedText = viewModel?.cathegories
        progressLbl.text = viewModel?.progress
        interactionButton.setImage(viewModel?.relation, for: .normal)
    }
}
