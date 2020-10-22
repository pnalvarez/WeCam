//
//  EditProgressView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProgressViewDelegate: class {
    func didConfirm(progress: Float)
}

class EditProgressView: UIView {
    
    private lazy var notchView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(rgb: 0xe0e3e3)
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Como está o progresso do seu projeto?"
        view.textAlignment = .center
        view.font = ThemeFonts.RobotoBold(18).rawValue
        view.textColor = .black
        return view
    }()
    
    private lazy var progressSlider: UISlider = {
        let view = UISlider(frame: .zero)
        view.setThumbImage(UIImage(named: "logo-apenas"), for: .normal)
        view.setThumbImage(UIImage(named: "logo-apenas"), for: .highlighted)
        view.backgroundColor = UIColor(rgb: 0xe0e0e0)
        view.tintColor = UIColor(rgb: 0xe0e0e0)
        return view
    }()
    
    private lazy var percentageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ThemeFonts.RobotoBold(16).rawValue
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private lazy var finishButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapFinish), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.backgroundColor = ThemeColors.mainRedColor.rawValue
        view.setTitle("Concluído", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = ThemeFonts.RobotoBold(16).rawValue
        return view
    }()
    
    private var progress: Float
    
    init(frame: CGRect,
         progress: Float) {
        self.progress = progress
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProgressView {
    
    @objc
    private func didTapClose() {
        
    }
    
    @objc
    private func didTapFinish() {
        
    }
}

extension EditProgressView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(notchView)
        addSubview(mainLbl)
        addSubview(progressSlider)
        addSubview(closeButton)
        addSubview(percentageLbl)
        addSubview(finishButton)
    }
    
    func setupConstraints() {
        notchView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(6)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(56)
            make.height.width.equalTo(31)
        }
        mainLbl.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.width.equalTo(216)
        }
        progressSlider.snp.makeConstraints { make in
            make.top.equalTo(mainLbl).offset(86)
            make.right.left.equalToSuperview().inset(130)
            make.height.equalTo(6)
        }
        
    }
    
    func configureViews() {
        
    }
}