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
    
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProjects? {
        didSet {
            buildProjectsFeed()
        }
    }
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?

    func setup(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?,
               delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil) {
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
        addSubview(headerLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
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
            make.bottom.equalToSuperview().inset(15)
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}


