//
//  FinishedProjectFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

protocol FinishedProjectFeedTableViewCellDelegate: class {
    func didSelectProject(index: Int)
}

class FinishedProjectFeedTableViewCell: UITableViewCell {
    
    private lazy var fixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = MainFeed.Constants.Fonts.finishedProjectFeedFixedLbl
        view.textColor = MainFeed.Constants.Colors.finishedProjectFeedFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.delegate = self
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.isHidden = true
        return view
    }()
    
    private weak var delegate: FinishedProjectFeedTableViewCellDelegate?
    
    private var viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed? {
        didSet {
            buildProjectsCarrousel()
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews as [UIView] {
            if !subview.isHidden
                && subview.alpha > 0
                && subview.isUserInteractionEnabled
                && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    func setup(delegate: FinishedProjectFeedTableViewCellDelegate? = nil,
               viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed) {
        self.delegate = delegate
        self.viewModel = viewModel
        applyViewCode()
    }
    
    func flushProjectsFeed() {
        for view in scrollView.subviews {
            if view is UIButton {
                view.removeFromSuperview()
            }
        }
        scrollView.layoutIfNeeded()
    }
    
    private func buildProjectsCarrousel() {
        var buttons = [UIButton]()
        guard let projects = viewModel?.projects else { return }
        let scrollWidth = MainFeed.Constants.Dimensions.Widths.finishedProjectsFeedOffset + ((MainFeed.Constants.Dimensions.Widths.finishedProjectButton + MainFeed.Constants.Dimensions.Widths.finishedProjectsFeedInterval) * CGFloat(projects.count))
        scrollView.contentSize = CGSize(width: scrollWidth, height: scrollView.frame.height)
        scrollView.isScrollEnabled = true
        for index in 0..<projects.count {
            let button = UIButton(frame: .zero)
            button.tag = index
            button.sd_setImage(with: URL(string: projects[index].image), for: .normal, completed: nil)
            button.addTarget(self, action: #selector(didTapProject(_:)), for: .touchUpInside)
            buttons.append(button)
            scrollView.addSubview(button)
            button.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(128)
                if index == 0 {
                    make.left.equalToSuperview().inset(22)
                } else {
                    make.left.equalTo(buttons[index-1].snp.right).offset(15)
                }
            }
        }
    }
    
    @objc private func didTapProject(_ sender: UIButton) {
        delegate?.didSelectProject(index: sender.tag)
    }
    
    deinit {
        flushProjectsFeed()
    }
}

extension FinishedProjectFeedTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.layoutIfNeeded()
//        for view in projectViews {
//            view.layoutIfNeeded()
//        }
    }
}

extension FinishedProjectFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(fixedLbl)
        scrollView.addSubview(container)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        fixedLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(220)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(fixedLbl.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(182)
        }
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().priority(250)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        fixedLbl.text = viewModel?.criteria
    }
}
