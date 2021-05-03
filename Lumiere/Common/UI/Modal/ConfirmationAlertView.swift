//
//  ConfirmationAlertView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ConfirmationAlertViewDelegate: AnyObject {
    func didTapAccept()
    func didTapRefuse()
}

class ConfirmationAlertView: UIView {
    
    private lazy var notchView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(rgb: 0xe3e0e0)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var confirmationLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = ThemeFonts.RobotoBold(18).rawValue
        view.textColor = ThemeColors.alertGray.rawValue
        view.numberOfLines = 0
        view.text = text
        return view
    }()
    
    private lazy var buttonContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var acceptButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(rgb: 0xededed)
        view.setTitle("Sim", for: .normal)
        view.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        view.titleLabel?.font = ThemeFonts.RobotoBold(16).rawValue
        view.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        return view
    }()
    
    private lazy var refuseButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(rgb: 0xededed)
        view.setTitle("Não", for: .normal)
        view.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        view.titleLabel?.font = ThemeFonts.RobotoBold(16).rawValue
        view.addTarget(self, action: #selector(didTapRefuse), for: .touchUpInside)
        return view
    }()
    
    private weak var delegate: ConfirmationAlertViewDelegate?
    
    private var text: String {
        didSet {
            confirmationLbl.text = text
        }
    }

    init(frame: CGRect,
         delegate: ConfirmationAlertViewDelegate? = nil,
         text: String = .empty) {
        self.delegate = delegate
        self.text = text
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(_ text: String) {
        self.text = text
    }
}

extension ConfirmationAlertView {
    
    @objc
    private func didTapAccept() {
        delegate?.didTapAccept()
    }
    
    @objc
    private func didTapRefuse() {
        delegate?.didTapRefuse()
    }
}

extension ConfirmationAlertView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(notchView)
        addSubview(confirmationLbl)
        buttonContainer.addSubview(acceptButton)
        buttonContainer.addSubview(refuseButton)
        addSubview(buttonContainer)
    }
    
    func setupConstraints() {
        notchView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
            make.width.equalTo(100)
        }
        confirmationLbl.snp.makeConstraints { make in
            make.top.equalTo(notchView.snp.bottom).offset(74)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        buttonContainer.snp.makeConstraints { make in
            make.top.equalTo(confirmationLbl.snp.bottom).offset(88)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(131)
        }
        acceptButton.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(55)
        }
        refuseButton.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(55)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
