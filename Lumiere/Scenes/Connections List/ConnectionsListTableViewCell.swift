//
//  ConnectionsListTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import SDWebImage

protocol ConnectionsListTableViewCellDelegate: class {
    func didTapRemoveButton(index: Int?)
}

class ConnectionsListTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        view.layer.borderColor = ConnectionsList.Constants.Colors.photoImageView
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ConnectionsList.Constants.Fonts.nameLbl
        view.textColor = ConnectionsList.Constants.Colors.nameLbl
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ConnectionsList.Constants.Fonts.ocupationLbl
        view.textColor = ConnectionsList.Constants.Colors.ocupationLbl
        return view
    }()
    
    private lazy var removeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        view.backgroundColor = ConnectionsList.Constants.Colors.removeButtonBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = ConnectionsList.Constants.Colors.removeButtonLayer
        view.setAttributedTitle(NSAttributedString(string: ConnectionsList
            .Constants
            .Texts
            .removeButton, attributes: [NSAttributedString.Key.font: ConnectionsList
                .Constants
                .Fonts
                .removeButton,
                                        NSAttributedString.Key.foregroundColor: ConnectionsList
                                            .Constants
                                            .Colors
                                            .removeButtonText]), for: .normal)
        return view
    }()
    
    private var index: Int?
    private var viewModel: ConnectionsList.Info.ViewModel.Connection?
    private var removeOptionActive: Bool?
    private weak var delegate: ConnectionsListTableViewCellDelegate?
    
    func setup(index: Int,
               viewModel: ConnectionsList.Info.ViewModel.Connection,
               removeOptionActive: Bool,
               delegate: ConnectionsListTableViewCellDelegate? = nil) {
        self.index = index
        self.viewModel = viewModel
        self.removeOptionActive = removeOptionActive
        self.delegate = delegate
        applyViewCode()
    }
}

extension ConnectionsListTableViewCell {
    
    @objc
    private func didTapRemoveButton() {
        delegate?.didTapRemoveButton(index: index)
    }
}

extension ConnectionsListTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
        addSubview(removeButton)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.height.width.equalTo(96)
        }
        nameLbl.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).offset(12)
            make.width.equalTo(118)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.equalTo(nameLbl)
            make.width.equalTo(118)
        }
        removeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(28)
            make.width.equalTo(72)
        }
    }
    
    func configureViews() {
        selectionStyle = .none
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        removeButton.isHidden = !(removeOptionActive ?? true)
    }
}
