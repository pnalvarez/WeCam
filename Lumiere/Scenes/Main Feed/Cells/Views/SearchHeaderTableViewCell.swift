//
//  SearchHeaderTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchHeaderTableViewCellDelegate: class {
    func didTapSearch()
}

class SearchHeaderTableViewCell: UITableViewCell {
    
    private lazy var lumiereHeader: DefaultHeaderView = {
        let view = DefaultHeaderView(frame: .zero)
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        view.setImage(MainFeed.Constants.Images.search, for: .normal)
        return view
    }()
    
    private weak var delegate: SearchHeaderTableViewCellDelegate?
    
    func setup(delegate: SearchHeaderTableViewCellDelegate? = nil) {
        self.delegate = delegate
        applyViewCode()
    }
    
    @objc
    private func didTapSearchButton() {
        delegate?.didTapSearch()
    }
}

extension SearchHeaderTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(lumiereHeader)
        addSubview(searchButton)
    }
    
    func setupConstraints() {
        lumiereHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(lumiereHeader)
            make.left.equalTo(lumiereHeader.snp.right).offset(12)
            make.width.height.equalTo(30)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
