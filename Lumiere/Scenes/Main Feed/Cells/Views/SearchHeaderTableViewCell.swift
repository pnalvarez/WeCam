//
//  SearchHeaderTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol SearchHeaderTableViewCellDelegate: AnyObject {
    func didTapSearch()
}

class SearchHeaderTableViewCell: UITableViewCell {
    
    private lazy var lumiereHeader: WCHeaderView = {
        let view = WCHeaderView(frame: .zero)
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
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(lumiereHeader)
            make.right.equalToSuperview().inset(24)
            make.width.height.equalTo(30)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
