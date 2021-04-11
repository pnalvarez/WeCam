//
//  ProjectParticipantsListTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

class ProjectParticipantsListTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ProjectParticipantsList.Constants.Fonts.nameLbl
        view.textColor = ProjectParticipantsList.Constants.Colors.nameLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ProjectParticipantsList.Constants.Fonts.ocupationLbl
        view.textColor = ProjectParticipantsList.Constants.Colors.ocupationLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        return view
    }()
    
    private(set) var viewModel: ProjectParticipantsList.Info.ViewModel.Participant?
    
    func setup(viewModel: ProjectParticipantsList.Info.ViewModel.Participant) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProjectParticipantsListTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
        addSubview(emailLbl)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(33)
            make.width.equalTo(100)
        }
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(17)
            make.width.equalTo(118)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView)
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.right.equalToSuperview()
        }
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(ocupationLbl.snp.bottom)
            make.left.equalTo(ocupationLbl)
            make.right.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
        emailLbl.attributedText = viewModel?.email
    }
}
