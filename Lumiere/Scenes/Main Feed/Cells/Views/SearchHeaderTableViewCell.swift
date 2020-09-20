//
//  SearchHeaderTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

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
    
    func setup() {
        applyViewCode()
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
}
