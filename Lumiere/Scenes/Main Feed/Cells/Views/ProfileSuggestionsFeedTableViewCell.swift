//
//  ProfileSuggestionsFeedTableViewCell.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 07/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProfileSuggestionsFeedTableViewCellDelegate: AnyObject {
    func didTapProfileSuggestion(index: Int)
    func didTapSeeAll()
}

class ProfileSuggestionsFeedTableViewCell: UITableViewCell {
    
    private lazy var headerLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = MainFeed.Constants.Texts.profileSuggestionsHeaderLbl
        view.textColor = MainFeed.Constants.Colors.profileSuggestionsHeaderLbl
        view.font = MainFeed.Constants.Fonts.profileSuggestionsHeaderLbl
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
        view.registerCell(cellType: ProfileSuggestionCollectionViewCell.self)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var seeAllButton: WCActionButton = {
        let view = WCActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSeeAll(_:)), for: .touchUpInside)
        view.text = MainFeed.Constants.Texts.profileSuggestionsSeeAllButton
        return view
    }()
    
    private weak var delegate: ProfileSuggestionsFeedTableViewCellDelegate?
    
    private var viewModel: MainFeed.Info.ViewModel.UpcomingProfiles? {
        didSet {
            reloadCollectionView()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flushContent()
    }
    
    func setup(delegate: ProfileSuggestionsFeedTableViewCellDelegate? = nil,
               viewModel: MainFeed.Info.ViewModel.UpcomingProfiles?) {
        self.delegate = delegate
        self.viewModel = viewModel
        applyViewCode()
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProfileSuggestionsFeedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.suggestions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: ProfileSuggestionCollectionViewCell.self)
        guard let suggestion = viewModel?.suggestions[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: suggestion)
        return cell
    }
}

extension ProfileSuggestionsFeedTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapProfileSuggestion(index: indexPath.item)
    }
}

extension ProfileSuggestionsFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 38)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 22, bottom: 0, right: 22)
    }
}
 

extension ProfileSuggestionsFeedTableViewCell {
    
    @objc
    private func didTapProfile(_ sender: UIButton) {
        delegate?.didTapProfileSuggestion(index: sender.tag)
    }
    
    @objc
    private func didTapSeeAll(_ sender: UIButton) {
        delegate?.didTapSeeAll()
    }
}

extension ProfileSuggestionsFeedTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(headerLbl)
        addSubview(collectionView)
        addSubview(seeAllButton)
    }
    
    func setupConstraints() {
        headerLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(22)
            make.width.equalTo(180)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLbl.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(headerLbl.snp.right).offset(12)
            make.centerY.equalTo(headerLbl)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}
