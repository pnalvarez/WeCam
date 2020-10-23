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
    func didSelectedNewCriteria(text: String)
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
    
    private lazy var selectionFilter: SelectionFilterView = {
        let view = SelectionFilterView(frame: .zero,
                                       selectedItem: MainFeed.Constants.Texts.allCriteria,
                                       delegate: self)
        return view
    }()
    
    private lazy var optionsStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fillEqually
        view.spacing = 0
        view.alignment = .center
        view.axis = .vertical
        view.isHidden = true
        return view
    }()
    
    private var criteriasViewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias? {
        didSet {
            buildOptionFilters()
        }
    }
    
    private var projectsViewModel: MainFeed.Info.ViewModel.UpcomingProjects? {
        didSet {
            buildProjectsFeed()
        }
    }
    
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?
    
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


    func setup(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?,
               delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil,
               criteriasViewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias? = nil) {
        self.projectsViewModel = viewModel
        self.delegate = delegate
        self.criteriasViewModel = criteriasViewModel
        applyViewCode()
    }
    
    func flushItems() {
        for view in mainContainer.subviews {
            view.removeFromSuperview()
        }
        for view in optionsStackView.arrangedSubviews {
            optionsStackView.removeArrangedSubview(view)
        }
        scrollView.layoutIfNeeded()
    }
    
    func resetSelectionFilter() {
        selectionFilter.selectedItem = MainFeed.Constants.Texts.allCriteria
        optionsStackView.subviews[0].backgroundColor = MainFeed.Constants.Colors.optionButtonSelected
    }
    
    func flushProjectsFeed() {
        for view in scrollView.subviews {
            if view is OnGoingProjectFeedResumeButton {
                view.removeFromSuperview()
            }
        }
        scrollView.layoutIfNeeded()
    }
    
    func setProjects(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?) {
        self.projectsViewModel = viewModel
    }
}

extension OnGoingProjectsFeedTableViewCell {
    
    private func buildProjectsFeed() {
        var buttons = [OnGoingProjectFeedResumeButton]()
        guard let projects = projectsViewModel?.projects else { return }
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
    
    private func buildOptionFilters() {
        guard let criterias = criteriasViewModel?.criterias else { return }
        let selectedIndex = criterias.firstIndex(where: { criteriasViewModel?.selectedCriteria == $0 })
        selectionFilter.selectedItem = criteriasViewModel?.selectedCriteria.criteria ?? .empty
        for index in 0..<criterias.count {
            let button = OptionFilterButton(frame: .zero, option: criterias[index].criteria)
            button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            button.tag = index
            if selectedIndex == index {
                button.backgroundColor = ProfileSuggestions.Constants.Colors.optionButtonSelected
            }
            optionsStackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(20)
            }
        }
    }
}

extension OnGoingProjectsFeedTableViewCell {
    
    @objc
    private func didTapOnGoingProject(_ sender: UIButton) {
        delegate?.didSelectProject(index: sender.tag)
    }
    
    @objc
    private func didSelectOption(_ sender: UIButton) {
        guard let text = criteriasViewModel?.criterias[sender.tag].criteria else { return }
        selectionFilter.selectedItem = text
        optionsStackView.isHidden = true
        optionsStackView.arrangedSubviews.forEach({
            if $0 == sender {
                $0.backgroundColor = MainFeed.Constants.Colors.optionButtonSelected
            } else {
                $0.backgroundColor = MainFeed.Constants.Colors.optionButtonUnselected
            }
        })
        flushProjectsFeed()
        delegate?.didSelectedNewCriteria(text: text)
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

extension OnGoingProjectsFeedTableViewCell: SelectionFilterViewDelegate {
    
    func didTapBottomSheetButton() {
        optionsStackView.isHidden = !optionsStackView.isHidden
    }
}

extension OnGoingProjectsFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(headerLbl)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(selectionFilter)
        addSubview(optionsStackView)
    }
    
    func setupConstraints() {
        headerLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(200)
        }
        selectionFilter.snp.makeConstraints { make in
            make.centerY.equalTo(headerLbl)
            make.left.equalTo(headerLbl.snp.right).offset(2)
            make.height.equalTo(18)
            make.right.equalToSuperview().inset(11)
        }
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(selectionFilter.snp.bottom)
            make.width.equalTo(selectionFilter)
            make.centerX.equalTo(selectionFilter)
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


