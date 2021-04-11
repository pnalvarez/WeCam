//
//  FinishedProjectFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

protocol FinishedProjectFeedTableViewCellDelegate: class {
    func didSelectFinishedProject(projectIndex: Int, cathegoryIndex: Int)
}

class FinishedProjectFeedTableViewCell: UITableViewCell {
    
    private lazy var fixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = MainFeed.Constants.Fonts.finishedProjectFeedFixedLbl
        view.textColor = MainFeed.Constants.Colors.finishedProjectFeedFixedLbl
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
        view.registerCell(cellType: FinishedProjectItemCollectionViewCell.self)
        view.backgroundColor = .white
        return view
    }()
    
    private weak var delegate: FinishedProjectFeedTableViewCellDelegate?
    
    private var index: Int?
    
    private var viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed? {
        didSet {
            reloadCollectionView()
        }
    }
    
    func setup(delegate: FinishedProjectFeedTableViewCellDelegate? = nil,
               index: Int? = nil,
               viewModel: MainFeed.Info.ViewModel.FinishedProjectFeed) {
        self.delegate = delegate
        self.index = index
        self.viewModel = viewModel
        applyViewCode()
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension FinishedProjectFeedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.projects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: FinishedProjectItemCollectionViewCell.self)
        guard let project = viewModel?.projects[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: project)
        return cell
    }
}

extension FinishedProjectFeedTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectFinishedProject(projectIndex: indexPath.item, cathegoryIndex: index ?? 0)
    }
}

extension FinishedProjectFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 182)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 22, bottom: 0, right: 22)
    }
}

extension FinishedProjectFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(fixedLbl)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        fixedLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(220)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(fixedLbl.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(182)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        fixedLbl.text = viewModel?.criteria
        selectionStyle = .none
    }
}
