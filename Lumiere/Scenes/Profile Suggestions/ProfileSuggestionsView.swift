//
//  ProfileSuggestionsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileSuggestionsView: UIView {
    
    private unowned var tableView: UITableView
    
    private lazy var mainHeader: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = ProfileSuggestions.Constants.Images.lumiere
        return view
    }()
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProfileSuggestions.Constants.Texts.mainLbl
        view.font = ProfileSuggestions.Constants.Fonts.mainLbl
        view.textColor = ProfileSuggestions.Constants.Colors.mainLbl
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    init(frame: CGRect,
         tableView: UITableView) {
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSuggestionsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}
