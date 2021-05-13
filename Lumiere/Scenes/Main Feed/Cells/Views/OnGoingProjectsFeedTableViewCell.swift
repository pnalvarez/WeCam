//
//  OnGoingProjectsFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 17/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol OnGoingProjectsFeedTableViewCellDelegate: AnyObject {
    func didSelectProject(index: Int)
    func didTapFilterCathegories()
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
    
    private lazy var filterButton: WCActionButton = {
        let view = WCActionButton(frame: .zero)
        view.text = MainFeed.Constants.Texts.filterCathegories
        view.addTarget(self, action: #selector(didTapFilterCathegories), for: .touchUpInside)
        return view
    }()
    
    private var projectsViewModel: MainFeed.Info.ViewModel.UpcomingProjects? {
        didSet {
            if let isEmpty = projectsViewModel?.projects.isEmpty, isEmpty {
                collectionView.backgroundView = WCEmptyListView(frame: .zero,
                                                                layout: .smallest,
                                                                text: "Sem projetos no seu feed ;(")
            } else {
                collectionView.backgroundView = nil
            }
            reloadCollectionView()
        }
    }
    
    private weak var delegate: OnGoingProjectsFeedTableViewCellDelegate?

    func setup(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?,
               delegate: OnGoingProjectsFeedTableViewCellDelegate? = nil) {
        self.projectsViewModel = viewModel
        self.delegate = delegate
        applyViewCode()
    }
    
    func setProjects(viewModel: MainFeed.Info.ViewModel.UpcomingProjects?) {
        self.projectsViewModel = viewModel
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc
    private func didTapFilterCathegories() {
        delegate?.didTapFilterCathegories()
    }
    
    @objc
    private func didTapOnGoingProject(_ sender: UIButton) {
        delegate?.didSelectProject(index: sender.tag)
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

extension OnGoingProjectsFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(headerLbl)
        addSubview(filterButton)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        headerLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(180)
        }
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerLbl)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(headerLbl.snp.right).offset(12)
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


