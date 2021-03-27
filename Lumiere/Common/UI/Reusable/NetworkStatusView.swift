//
//  NetworkStatusView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 24/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

enum NetworkStatusViewState {
    case connected
    case disconnected
    
    var label: String {
        switch self {
        case .connected:
            return "Conexão reestabelecida"
        case .disconnected:
            return "Seu dispositivo encontra-se sem acesso a internet"
        }
    }
    
    var iconImage: String {
        switch self {
        case .connected:
            return ""
        case .disconnected:
            return ""
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .connected:
            return ThemeColors.connectedGreen.rawValue.withAlphaComponent(0.4)
        case .disconnected:
            return ThemeColors.disconnectedRed.rawValue.withAlphaComponent(0.4)
        }
    }
}

class NetworkStatusView: UIView {
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var statusLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = ThemeFonts.RobotoRegular(12).rawValue
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var status: NetworkStatusViewState? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewCode()
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            if let superview = self.superview {
                self.snp.updateConstraints { make in
                    make.bottom.equalTo(superview.safeAreaLayoutGuide.snp.top)
                }
                self.layoutIfNeeded()
            }
        })
    }
    
    private func updateUI() {
        statusLbl.text = status?.label
        iconImageView.image = UIImage(named: status?.iconImage ?? .empty)
        backgroundColor = status?.backgroundColor
    }
}

extension NetworkStatusView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(statusLbl)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(31)
        }
        statusLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
}
