//
//  ProfileSuggestionsFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 07/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsFeedTableViewCellDelegate: class {
    func didTapProfileSuggestion(index: Int)
    func didTapSeeAll()
}

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
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var seeAllButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        view.setTitle(MainFeed.Constants.Texts.profileSuggestionsSeeAllButton, for: .normal)
        view.setTitleColor(MainFeed.Constants.Colors.profileSuggestionsSeeAllButton, for: .normal)
        view.titleLabel?.font = MainFeed.Constants.Fonts.profileSuggestionsSeeAllButton
        return view
    }()
    
    private weak var delegate: ProfileSuggestionsFeedTableViewCellDelegate?
    
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProfiles?{
        didSet {
            buildProfileSuggestionsButtons()
        }
    }
    
    func setup(delegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil,
               viewModel: MainFeed.Info.ViewModel.UpcomingProfiles?) {
        self.delegate = delegate
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension ProfileSuggestionsFeedTableViewCell {
    
    private func buildProfileSuggestionsButtons() {
        var buttons: [ProfileResumeButton] = .empty
        guard let suggestions = viewModel?.suggestions else { return }
        for index in 0..<suggestions.count {
            let button = ProfileResumeButton(frame: .zero,
                                             image: suggestions[index].image,
                                             name: suggestions[index].name,
                                             ocupation: suggestions[index].ocupation)
            button.tag = index
            button.addTarget(self, action: #selector(didTapProfile(_:)), for: .touchUpInside)
            buttons.append(button)
            mainContainer.addSubview(button)
            button.snp.makeConstraints { make in
                if index < 2 {
                    make.top.equalToSuperview().inset(10)
                    make.left.equalToSuperview().inset(22)
                } else {
                    if index % 2 == 0 {
                        make.top.equalToSuperview().inset(10)
                        make.left.equalTo(buttons[index-1]).offset(14)
                    } else {
                        make.top.equalTo(buttons[index-1]).offset(11)
                        make.left.equalTo(buttons[index-2]).offset(14)
                    }
                }
                make.height.equalTo(37)
                make.width.equalTo(127)
            }
        }
    }
}

extension ProfileSuggestionsFeedTableViewCell {
    
    @objc
    private func didTapProfile(_ sender: UIButton) {
        delegate?.didTapProfileSuggestion(index: sender.tag)
    }
    
    @objc
    private func didTapSeeAll() {
        delegate?.didTapSeeAll()
    }
}

extension ProfileSuggestionsFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(headerLbl)
        addSubview(seeAllButton)
    }
    
    func setupConstraints() {
        headerLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(150)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLbl.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(18)
            make.top.equalTo(scrollView.snp.bottom).offset(15)
            make.height.equalTo(16)
            make.width.equalTo(70)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
