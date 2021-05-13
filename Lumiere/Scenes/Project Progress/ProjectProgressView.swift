//
//  ProjectProgressView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProjectProgressView: BaseView, ModalViewable {

    private unowned var advanceButton: WCActionButton
    private unowned var progressView: WCProgressView
    
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
         advanceButton: WCActionButton,
         progressView: WCProgressView) {
        self.advanceButton = advanceButton
        self.progressView = progressView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectProgressView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(advanceButton)
        addSubview(mainLbl)
        addSubview(progressView)
    }
    
    func setupConstraints() {
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(102)
            make.centerX.equalToSuperview()
            make.width.equalTo(82)
        }
        mainLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.left.right.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(mainLbl.snp.bottom).offset(120)
            make.left.right.equalToSuperview()
            make.height.equalTo(96)
        }
    }
}
