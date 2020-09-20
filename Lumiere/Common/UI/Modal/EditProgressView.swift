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
    func didClose()
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
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var progressSlider: UISlider = {
        let view = UISlider(frame: .zero)
        view.setThumbImage(UIImage.imageWithImage(image: UIImage(named: "logo-apenas") ?? UIImage(), scaledToSize: CGSize(width: 57, height: 67)), for: .normal)
        view.setThumbImage(UIImage.imageWithImage(image: UIImage(named: "logo-apenas") ?? UIImage(), scaledToSize: CGSize(width: 57, height: 67)), for: .highlighted)
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
    
    private weak var delegate: EditProgressViewDelegate?
    
    var progress: Float {
        didSet {
            progressSlider.setValue(progress, animated: false)
            percentageLbl.text = "\(progressSlider.value)%"
        }
    }
    
    init(frame: CGRect,
         delegate: EditProgressViewDelegate? = nil,
         progress: Float) {
        self.delegate = delegate
        self.progress = progress
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProgressView {
    
    @objc
    private func didTapClose() {
        delegate?.didClose()
    }
    
    @objc
    private func didTapFinish() {
        delegate?.didConfirm(progress: progressSlider.value)
    }
    
    @objc
    private func progressDidChange() {
        percentageLbl.text = "\(progress)%"
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
            make.width.equalTo(300)
        }
        progressSlider.snp.makeConstraints { make in
            make.top.equalTo(mainLbl).offset(120)
            make.right.left.equalToSuperview().inset(130)
            make.height.equalTo(6)
        }
        percentageLbl.snp.makeConstraints { make in
            make.top.equalTo(progressSlider.snp.bottom).offset(38)
            make.centerX.equalTo(progressSlider)
            make.width.equalTo(50)
        }
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(percentageLbl.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(94)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        percentageLbl.text = "\(progress)%"
    }
}
