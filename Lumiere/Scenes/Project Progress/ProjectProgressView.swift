//
//  ProjectProgressView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProjectProgressView: UIView {
    
    private unowned var backButton: UIButton
    private unowned var advanceButton: UIButton
    private unowned var progressSlider: UISlider
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = ProjectProgress.Constants.Colors.mainLbl
        view.font = ProjectProgress.Constants.Fonts.mainLbl
        view.text = ProjectProgress.Constants.Texts.mainLbl
        return view
    }()
    
    private lazy var zeroPercentLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = ProjectProgress.Constants.Colors.zeroPercentLbl
        view.font = ProjectProgress.Constants.Fonts.zeroPercentLbl
        view.text = ProjectProgress.Constants.Texts.zeroPercentLbl
        return view
    }()
    
    private lazy var hundredPercentLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.textColor = ProjectProgress.Constants.Colors.hundredPercentLbl
        view.font = ProjectProgress.Constants.Fonts.hundredPercentLbl
        view.text = ProjectProgress.Constants.Texts.hundredPercentLbl
        return view
    }()
    
    init(frame: CGRect,
         backButton: UIButton,
         advanceButton: UIButton,
         progressSlider: UISlider) {
        self.backButton = backButton
        self.advanceButton = advanceButton
        self.progressSlider = progressSlider
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectProgressView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(advanceButton)
        addSubview(mainLbl)
        addSubview(progressSlider)
        addSubview(zeroPercentLbl)
        addSubview(hundredPercentLbl)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().inset(28)
            make.height.width.equalTo(31)
        }
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.right.equalToSuperview().inset(28)
            make.height.equalTo(19)
            make.width.equalTo(59)
        }
        mainLbl.snp.makeConstraints { make in
            make.top.equalTo(advanceButton.snp.bottom).offset(47)
            make.centerX.left.right.equalToSuperview()
        }
        progressSlider.snp.makeConstraints { make in
            make.top.equalTo(mainLbl.snp.bottom).offset(164)
            make.left.equalToSuperview().inset(57)
            make.right.equalToSuperview().inset(52)
            make.height.equalTo(11)
        }
        zeroPercentLbl.snp.makeConstraints { make in
            make.top.equalTo(progressSlider.snp.bottom).offset(83)
            make.left.equalToSuperview().inset(57)
            make.width.equalTo(50)
        }
        hundredPercentLbl.snp.makeConstraints { make in
            make.top.equalTo(progressSlider.snp.bottom).offset(83)
            make.right.equalToSuperview().inset(52)
            make.width.equalTo(50)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
