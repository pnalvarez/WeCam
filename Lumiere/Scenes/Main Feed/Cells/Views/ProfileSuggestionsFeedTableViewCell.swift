//
//  ProfileSuggestionsFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 07/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProfileSuggestionsFeedTableViewCell: UITableViewCell {
    
    private lazy var headerLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = MainFeed.Constants.Texts.profileSuggestionsHeaderLbl
        view.textColor = MainFeed.Constants.Colors.profileSuggestionsHeaderLbl
        view.font = MainFeed.Constants.Fonts.profileSuggestionsHeaderLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        return view
    }()
}
