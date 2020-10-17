//
//  OnGoingProjectsFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 17/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectsFeedTableViewCellDelegate: class {
    func didSelectProject(index: Int)
}

class OnGoingProjectsFeedTableViewCell: UITableViewCell {
    
    private lazy var headerLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = MainFeed.Constants.Texts.ongoingProjectsHeaderLbl
        view.textColor = MainFeed.Constants.Colors.ongoingProjectsHeaderLbl
        view.font = MainFeed.Constants.Fonts.ongoingProjectsHeaderLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.clipsToBounds = true
        view.delegate = self
        return view
    }()
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        return view
    }()
    
    private var index: Int?
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProjects? {
        didSet {
            buildProjectsFeed()
        }
    }
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?

    func setup(index: Int,
               viewModel: MainFeed.Info.ViewModel.UpcomingProjects,
               delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil) {
        self.index = index
        self.viewModel = viewModel
        self.delegate = delegate
        applyViewCode()
    }
    
    func flushItems() {
        for view in mainContainer.subviews {
            view.removeFromSuperview()
        }
        scrollView.layoutIfNeeded()
    }
}

extension OnGoingProjectsFeedTableViewCell {
    
    private func buildProjectsFeed() {
        
    }
}

extension OnGoingProjectsFeedTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.layoutIfNeeded()
        for view in mainContainer.subviews {
            view.layoutIfNeeded()
        }
    }
}

extension OnGoingProjectsFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}


