//
//  SearchHeaderTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchHeaderTableViewCellDelegate: class {
    func didTapSearch(withText text: String)
}

class SearchHeaderTableViewCell: UITableViewCell {
    
    private lazy var lumiereHeader: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = MainFeed.Constants.Images.lumiere
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = MainFeed.Constants.Colors.searchTextFieldLayer
        view.font = MainFeed.Constants.Fonts.searchTextField
        view.textColor = MainFeed.Constants.Colors.searchTextFieldText
        view.textAlignment = .left
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = MainFeed.Constants.Colors.dividerView
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        view.setImage(MainFeed.Constants.Images.search, for: .normal)
        return view
    }()
    
    private weak var delegate: SearchHeaderTableViewCellDelegate?
    
    func setup(delegate: SearchHeaderTableViewCellDelegate? = nil) {
        self.delegate = delegate
        applyViewCode()
    }
}

extension SearchHeaderTableViewCell {
    
    @objc
    private func didTapSearch() {
        delegate?.didTapSearch(withText: searchTextField.text ?? .empty)
    }
}

extension SearchHeaderTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(lumiereHeader)
        searchTextField.addSubview(dividerView)
        searchTextField.addSubview(searchButton)
        addSubview(searchTextField)
    }
    
    func setupConstraints() {
        lumiereHeader.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(lumiereHeader.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(242)
            make.height.equalTo(18)
        }
        dividerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(1)
        }
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(2)
            make.width.height.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
