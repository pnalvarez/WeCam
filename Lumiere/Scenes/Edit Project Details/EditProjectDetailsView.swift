//
//  EditProjectDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class EditProjectDetailsView: UIView {
    
    private unowned var backButton: DefaultBackButton
    private unowned var projectTitleTextField: UITextField
    private unowned var teamValueLbl: UILabel
    private unowned var sinopsisTextView: UITextView
    private unowned var needTextView: UITextView
    private unowned var publishButton: UIButton
    private unowned var loadingView: LoadingView
    
    private lazy var projectTitleFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.projectTitleLbl
        view.textColor = EditProjectDetails.Constants.Colors.projectTitleFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.projectTitleLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var teamFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.teamFixedLbl
        view.textColor = EditProjectDetails.Constants.Colors.teamFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.teamFixedLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var sinopsisFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.sinopsisFixedLbl
        view.textColor = EditProjectDetails.Constants.Colors.sinopsisFixedLbl
        view.font = EditProjectDetails.Constants.Fonts.sinopsisFixedLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var needLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = EditProjectDetails.Constants.Colors.needLbl
        view.text = EditProjectDetails.Constants.Texts.needLbl
        view.font = EditProjectDetails.Constants.Fonts.needLbl
        view.textAlignment = .center
        return view
    }()
    
    init(frame: CGRect,
         backButton: DefaultBackButton,
         projectTitleTextField: UITextField,
         sinopsisTextView: UITextView,
         needTextView: UITextView,
         teamValueLbl: UILabel,
         publishButton: UIButton,
         loadingView: LoadingView) {
        self.backButton = backButton
        self.projectTitleTextField = projectTitleTextField
        self.sinopsisTextView = sinopsisTextView
        self.needTextView = needTextView
        self.teamValueLbl = teamValueLbl
        self.publishButton = publishButton
        self.loadingView = loadingView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(projectTitleFixedLbl)
        addSubview(projectTitleTextField)
        addSubview(teamFixedLbl)
        addSubview(teamValueLbl)
        addSubview(sinopsisFixedLbl)
        addSubview(sinopsisTextView)
        addSubview(needLbl)
        addSubview(needTextView)
        addSubview(publishButton)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
            make.height.width.equalTo(31)
        }
        projectTitleFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(1)
            make.left.equalTo(backButton.snp.right).offset(8)
            make.width.equalTo(200)
        }
        projectTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(projectTitleFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(projectTitleFixedLbl)
            make.width.equalTo(250)
        }
        teamFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(projectTitleTextField.snp.bottom).offset(20)
            make.left.equalTo(backButton.snp.right).offset(8)
            make.width.equalTo(59)
        }
        teamValueLbl.snp.makeConstraints { make in
            make.top.equalTo(teamFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(teamFixedLbl)
            make.width.equalTo(250)
        }
        sinopsisFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(teamValueLbl.snp.bottom).offset(50)
            make.left.equalTo(teamFixedLbl)
            make.width.equalTo(59)
        }
        sinopsisTextView.snp.makeConstraints { make in
            make.top.equalTo(sinopsisFixedLbl.snp.bottom).offset(5)
            make.left.equalTo(sinopsisFixedLbl)
            make.width.equalTo(268)
            make.height.equalTo(150)
        }
        needLbl.snp.makeConstraints { make in
            make.top.equalTo(sinopsisTextView.snp.bottom).offset(20)
            make.left.equalTo(sinopsisTextView)
            make.width.equalTo(100)
        }
        needTextView.snp.makeConstraints { make in
            make.top.equalTo(needLbl.snp.bottom)
            make.left.equalTo(needLbl)
            make.width.equalTo(258)
            make.height.equalTo(59)
        }
        publishButton.snp.makeConstraints { make in
            make.top.equalTo(needTextView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
