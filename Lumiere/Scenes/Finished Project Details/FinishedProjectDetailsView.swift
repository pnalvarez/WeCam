//
//  FinishedProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class FinishedProjectDetailsView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var confirmationAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var closeButton: DefaultCloseButton
    private unowned var backButton: DefaultBackButton
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
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = FinishedProjectDetails.Constants.Fonts.titleLbl
        view.textColor = FinishedProjectDetails.Constants.Colors.titleLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var sinopsisLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = FinishedProjectDetails.Constants.Fonts.sinopsisLbl
        view.textColor = FinishedProjectDetails.Constants.Colors.sinopsisLbl
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
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.contentSize = CGSize(width: view.frame.width, height: 1000)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private var viewModel: FinishedProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         confirmationAlertView: ConfirmationAlertView,
         translucentView: UIView,
         closeButton: DefaultCloseButton,
         backButton: DefaultBackButton,
         watchButton: UIButton,
         interactionButton: UIButton,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton) {
        self.activityView = activityView
        self.confirmationAlertView = confirmationAlertView
        self.translucentView = translucentView
        self.closeButton = closeButton
        self.backButton = backButton
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
    
    func displayConfirmationModal(forRelation relation: FinishedProjectDetails.Info.ViewModel.Relation) {
        confirmationAlertView.setupText(relation.relation.confirmationAlertDescription)
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = false
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationModal() {
        self.translucentView.isHidden = true
        self.confirmationAlertView.snp.remakeConstraints { make in
            make.top.equalTo(self.translucentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.translucentView)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
}

extension FinishedProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(closeButton)
        mainContainer.addSubview(backButton)
        mainContainer.addSubview(photoImageView)
        mainContainer.addSubview(titleLbl)
        containerView.addSubview(sinopsisLbl)
        mainContainer.addSubview(containerView)
        mainContainer.addSubview(teamFixedLbl)
        mainContainer.addSubview(teamCollectionView)
        mainContainer.addSubview(moreInfoButton)
        mainContainer.addSubview(interactionButton)
        mainContainer.addSubview(watchButton)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(translucentView)
        addSubview(confirmationAlertView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        confirmationAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(28)
            make.height.width.equalTo(31)
        }
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(28)
            make.height.width.equalTo(31)
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(24)
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
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
    }
    
    func configureViews() {
        photoImageView.sd_setImage(with: URL(string: viewModel?.image ?? .empty), completed: nil)
        titleLbl.text = viewModel?.title
        sinopsisLbl.text = viewModel?.sinopsis
    }
}
