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
    
    private lazy var searchTextField: DefaultSearchTextField = {
        let view = DefaultSearchTextField(frame: .zero)
        view.searchDelegate = self
        return view
    }()
    
    private weak var delegate: SearchHeaderTableViewCellDelegate?
    
    func setup(delegate: SearchHeaderTableViewCellDelegate? = nil) {
        self.delegate = delegate
        applyViewCode()
    }
}

extension SearchHeaderTableViewCell: DefaultSearchTextFieldDelegate {
    
    func didTapSearch(searchTextField: DefaultSearchTextField) {
        delegate?.didTapSearch(withText: searchTextField.text ?? .empty)
    }
}

extension SearchHeaderTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(lumiereHeader)
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
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
