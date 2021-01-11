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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.assignProtocols(to: self)
        view.alwaysBounceHorizontal = true
        view.bounces = false
        view.registerCell(cellType: OnGoingProjectItemCollectionViewCell.self)
        view.backgroundColor = .white
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
            reloadCollectionView()
        }
    }
    
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?

    func setup(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?,
               delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil,
               criteriasViewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias? = nil) {
        self.projectsViewModel = viewModel
        self.delegate = delegate
        self.criteriasViewModel = criteriasViewModel
        applyViewCode()
    }
    
    func resetSelectionFilter() {
        selectionFilter.selectedItem = MainFeed.Constants.Texts.allCriteria
        optionsStackView.subviews[0].backgroundColor = MainFeed.Constants.Colors.optionButtonSelected
    }
    
    func setProjects(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?) {
        self.projectsViewModel = viewModel
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension OnGoingProjectsFeedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectsViewModel?.projects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: OnGoingProjectItemCollectionViewCell.self)
        guard let project = projectsViewModel?.projects[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: project)
        return cell
    }
}

extension OnGoingProjectsFeedTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectProject(index: indexPath.item)
    }
}

extension OnGoingProjectsFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 95, height: 94)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 22, bottom: 0, right: 22)
    }
}

extension OnGoingProjectsFeedTableViewCell {
    
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
        delegate?.didSelectedNewCriteria(text: text)
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
        addSubview(collectionView)
        addSubview(selectionFilter)
        addSubview(optionsStackView)
    }
    
    func setupConstraints() {
        headerLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(180)
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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLbl.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}


