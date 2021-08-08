//
//  EmptyListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 15/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class EmptyListView: UIView {
    
    private lazy var centralContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.emptyRedColor.rawValue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var centralLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = ThemeFonts.RobotoBold(14).rawValue
        view.textColor = ThemeColors.whiteThemeColor.rawValue
        view.textAlignment = .center
        return view
    }()
    
    private lazy var topCircleView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.emptyRedColor.rawValue
        return view
    }()
    
    private lazy var bottomCircleView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.emptyRedColor.rawValue
        return view
    }()
    
    private var text: String
    
    init(frame: CGRect,
         text: String) {
        self.text = text
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topCircleView.layer.cornerRadius = topCircleView.frame.height / 2
        topCircleView.clipsToBounds = true
        bottomCircleView.layer.cornerRadius = bottomCircleView.frame.height / 2
        bottomCircleView.clipsToBounds = true
    }
}

extension EmptyListView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        centralContainer.addSubview(centralLbl)
        addSubview(centralContainer)
        addSubview(topCircleView)
        addSubview(bottomCircleView)
    }
    
    func setupConstraints() {
        centralContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(301)
            make.height.equalTo(46)
        }
        centralLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        topCircleView.snp.makeConstraints { make in
            make.top.equalTo(centralContainer.snp.bottom).offset(15)
            make.right.equalTo(centralContainer.snp.right).offset(-36)
            make.height.width.equalTo(31)
        }
        bottomCircleView.snp.makeConstraints { make in
            make.top.equalTo(topCircleView.snp.bottom).offset(6)
            make.centerX.equalTo(topCircleView.snp.centerX).offset(16)
            make.height.width.equalTo(20)
        }
    }
    
    func configureViews() {
        centralLbl.text = text
    }
}
