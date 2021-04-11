//
//  ProfileSuggestionsTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsTableViewCellDelegate: class {
    func didTapAdd(index: Int)
    func didTapRemove(index: Int)
    func didEndFading(index: Int)
}

class ProfileSuggestionsTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: WCListItemImageView = {
        let view = WCListItemImageView(frame: .zero)
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = ProfileSuggestions.Constants.Colors.nameLbl
        view.font = ProfileSuggestions.Constants.Fonts.nameLbl
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var ocupationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = ProfileSuggestions.Constants.Colors.ocupationLbl
        view.font = ProfileSuggestions.Constants.Fonts.ocupationLbl
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.tag = 0
        view.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.setTitle(ProfileSuggestions.Constants.Texts.addButton, for: .normal)
        view.setTitleColor(ProfileSuggestions.Constants.Colors.addButtonText, for: .normal)
        view.backgroundColor = ProfileSuggestions.Constants.Colors.addButtonBackground
        view.titleLabel?.font = ProfileSuggestions.Constants.Fonts.addButton
        return view
    }()
    
    private lazy var removeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.tag = 1
        view.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.setTitle(ProfileSuggestions.Constants.Texts.removeButton, for: .normal)
        view.setTitleColor(ProfileSuggestions.Constants.Colors.removeButtonText, for: .normal)
        view.backgroundColor = ProfileSuggestions.Constants.Colors.removeButtonBackground
        view.titleLabel?.font = ProfileSuggestions.Constants.Fonts.removeButton
        return view
    }()
    
    private var index: Int?
    private weak var delegate: ProfileSuggestionsTableViewCellDelegate?
    private var viewModel: ProfileSuggestions.Info.ViewModel.Profile?
    
    func setup(index: Int,
               delegate: ProfileSuggestionsTableViewCellDelegate? = nil,
               viewModel: ProfileSuggestions.Info.ViewModel.Profile) {
        self.index = index
        self.delegate = delegate
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func fade() {
        UIView.animate(withDuration: 1, animations: {
            for view in self.subviews {
                view.alpha = 0
            }
        }) { (result) in
            if result {
                self.delegate?.didEndFading(index: self.index ?? 0)
            }
        }
    }
}

extension ProfileSuggestionsTableViewCell {
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        if sender.tag == 0 {
            delegate?.didTapAdd(index: index ?? 0)
        } else {
            delegate?.didTapRemove(index: index ?? 0)
        }
    }
}

extension ProfileSuggestionsTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(nameLbl)
        addSubview(ocupationLbl)
        addSubview(addButton)
        addSubview(removeButton)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(84)
            make.left.equalToSuperview().inset(16)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView).offset(10)
            make.left.equalTo(photoImageView.snp.right).offset(12)
            make.right.equalToSuperview().inset(28)
        }
        ocupationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.left.right.equalTo(nameLbl)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(ocupationLbl.snp.bottom).offset(18)
            make.right.equalTo(removeButton.snp.left).offset(-18)
            make.width.equalTo(82)
            make.height.equalTo(23)
        }
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(addButton)
            make.right.equalToSuperview().inset(17)
            make.width.height.equalTo(addButton)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        photoImageView.setImage(withURL: viewModel?.image ?? .empty)
        nameLbl.text = viewModel?.name
        ocupationLbl.text = viewModel?.ocupation
    }
}
