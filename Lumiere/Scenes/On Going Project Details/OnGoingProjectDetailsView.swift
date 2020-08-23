//
//  OnGoingProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import SDWebImage

class OnGoingProjectDetailsView: UIView {
    
    private unowned var closeButton: UIButton
    private unowned var teamCollectionView: UICollectionView
    private unowned var moreInfoButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var activityView: UIActivityIndicatorView
    
    private lazy var infoContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.containerInfoBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectDetails.Constants.Colors.containerInfoLayer
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.titleLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.titleLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var sinopsisLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.sinopsisLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.sinopsisLbl
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var teamFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.teamFixedLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.teamFixedLbl
        view.textColor = OnGoingProjectDetails.Constants.Colors.teamFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var needFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = OnGoingProjectDetails.Constants.Texts.needFixedLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.needFixedLbl
        view.textColor = OnGoingProjectDetails.Constants.Colors.needFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var dotView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.dotView
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var needValueLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = OnGoingProjectDetails.Constants.Colors.needValueLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.needValueLbl
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project?
    
    init(frame: CGRect,
         closeButton: UIButton,
         teamCollectionView: UICollectionView,
         moreInfoButton: UIButton,
         imageButton: UIButton,
         activityView: UIActivityIndicatorView) {
        self.closeButton = closeButton
        self.teamCollectionView = teamCollectionView
        self.moreInfoButton = moreInfoButton
        self.imageButton = imageButton
        self.activityView = activityView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: OnGoingProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension OnGoingProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(closeButton)
        addSubview(imageButton)
        infoContainer.addSubview(titleLbl)
        infoContainer.addSubview(sinopsisLbl)
        addSubview(infoContainer)
        addSubview(teamFixedLbl)
        addSubview(teamCollectionView)
        addSubview(moreInfoButton)
        addSubview(needFixedLbl)
        addSubview(dotView)
        addSubview(needValueLbl)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.right.equalToSuperview().inset(35)
            make.height.width.equalTo(31)
        }
        imageButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(82)
        }
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(14)
            make.left.equalToSuperview().inset(56)
            make.right.equalToSuperview().inset(51)
            make.height.equalTo(88)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.left.right.equalToSuperview()
        }
        sinopsisLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(infoContainer.snp.bottom).offset(19)
            make.left.equalTo(infoContainer)
            make.width.equalTo(49)
        }
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(17)
            make.left.equalTo(teamFixedLbl)
            make.right.equalToSuperview().inset(59)
            make.height.equalTo(115)
        }
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(teamCollectionView.snp.bottom).offset(12)
            make.right.equalTo(teamCollectionView)
            make.height.equalTo(19)
            make.width.equalTo(103)
        }
        needFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(30)
            make.left.equalTo(teamCollectionView)
            make.width.equalTo(94)
        }
        dotView.snp.makeConstraints { make in
            make.top.equalTo(needFixedLbl.snp.bottom).offset(32)
            make.left.equalTo(needFixedLbl)
            make.height.width.equalTo(10)
        }
        needValueLbl.snp.makeConstraints { make in
            make.top.equalTo(needFixedLbl.snp.bottom).offset(28)
            make.left.equalTo(dotView.snp.right).offset(12)
            make.width.equalTo(200)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        titleLbl.text = viewModel?.title
        sinopsisLbl.text = viewModel?.sinopsis
        needValueLbl.text = viewModel?.needing
        guard let image = viewModel?.image else { return }
        imageButton.sd_setImage(with: URL(string: image), for: .normal, completed: nil)
        imageButton.isUserInteractionEnabled = false
    }
}
