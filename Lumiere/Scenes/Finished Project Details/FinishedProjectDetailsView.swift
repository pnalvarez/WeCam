//
//  FinishedProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class FinishedProjectDetailsView: BaseView, ModalViewable {

    private unowned var watchButton: UIButton
    private unowned var interactionButton: UIButton
    private unowned var teamCollectionView: UICollectionView
    private unowned var moreInfoButton: UIButton
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderWidth = 1
        view.layer.borderColor = FinishedProjectDetails.Constants.Colors.containerViewLayer
        view.layer.cornerRadius = 4
        view.backgroundColor = FinishedProjectDetails.Constants.Colors.containerViewBackground
        return view
    }()
    
    private lazy var titleLbl: WCUILabelRobotoRegular16 = {
        let view = WCUILabelRobotoRegular16(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var sinopsisLbl: WCUILabelRobotoRegular12 = {
        let view = WCUILabelRobotoRegular12(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var teamFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = FinishedProjectDetails.Constants.Fonts.teamFixedLbl
        view.textColor = FinishedProjectDetails.Constants.Colors.teamFixedLbl
        view.text = FinishedProjectDetails.Constants.Texts.teamFixedLbl
        return view
    }()
    
    private lazy var scrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()

    private var viewModel: FinishedProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         watchButton: UIButton,
         interactionButton: UIButton,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton) {
        self.watchButton = watchButton
        self.interactionButton = interactionButton
        self.teamCollectionView = teamCollectionView
        self.moreInfoButton = moreInfoButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: FinishedProjectDetails.Info.ViewModel.Project?) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension FinishedProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        scrollView.addSubview(photoImageView)
        scrollView.addSubview(titleLbl)
        containerView.addSubview(sinopsisLbl)
        scrollView.addSubview(containerView)
        scrollView.addSubview(teamFixedLbl)
        scrollView.addSubview(teamCollectionView)
        scrollView.addSubview(moreInfoButton)
        scrollView.addSubview(interactionButton)
        scrollView.addSubview(watchButton)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(182)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(188)
        }
        sinopsisLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(18)
            make.left.equalTo(containerView)
            make.width.equalTo(60)
        }
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(17)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(115)
        }
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(teamCollectionView.snp.bottom).offset(12)
            make.right.equalTo(teamCollectionView).offset(-10)
            make.height.equalTo(19)
            make.width.equalTo(103)
        }
        interactionButton.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(30)
        }
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(interactionButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(30)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.right.left.equalToSuperview()
        }
    }
    
    func configureViews() {
        photoImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        titleLbl.text = viewModel?.title
        sinopsisLbl.text = viewModel?.sinopsis
    }
}
