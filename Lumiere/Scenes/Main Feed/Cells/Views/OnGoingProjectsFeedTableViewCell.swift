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
        view.isHidden = true
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
        var buttons = [OnGoingProjectFeedResumeButton]()
        guard let projects = viewModel?.projects else { return }
        let scrollWidth = MainFeed.Constants.Dimensions.Widths.ongoingProjectsFeedOffset + ((MainFeed.Constants.Dimensions.Widths.ongoingProjectResumeButton + MainFeed.Constants.Dimensions.Widths.ongoingProfojectsFeedInterval) * CGFloat(projects.count))
        scrollView.contentSize = CGSize(width: scrollWidth, height: scrollView.frame.height)
        for index in 0..<projects.count {
            let button = OnGoingProjectFeedResumeButton(frame: .zero,
                                                        image: projects[index].image,
                                                        progress: projects[index].progress)
            button.tag = index
            button.addTarget(self, action: #selector(didTapOnGoingProject(_:)), for: .touchUpInside)
            buttons.append(button)
            scrollView.addSubview(button)
            button.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(95)
                make.width.equalTo(84)
                if index == 0 {
                    make.left.equalToSuperview().inset(22)
                } else {
                    make.left.equalTo(buttons[index-1].snp.right).offset(10)
                }
            }
        }
    }
}

extension OnGoingProjectsFeedTableViewCell {
    
    @objc
    private func didTapOnGoingProject(_ sender: UIButton) {
        delegate?.didSelectProject(index: sender.tag)
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
            make.width.equalTo(200)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLbl.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
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


