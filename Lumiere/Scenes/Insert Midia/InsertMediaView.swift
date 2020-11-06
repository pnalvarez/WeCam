//
//  InsertMediaView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class InsertMediaView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var backButton: DefaultBackButton
    private unowned var inputTextField: UITextField
    private unowned var urlErrorView: EmptyListView
    private unowned var playerView: WKYTPlayerView
    private unowned var submitButton: UIButton
    
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
    
    private lazy var insertUrlLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InsertMedia.Constants.Colors.insertUrlLbl
        view.text = InsertMedia.Constants.Texts.insertUrlLbl
        view.font = InsertMedia.Constants.Fonts.insertUrlLbl
        return view
    }()
    
    private lazy var previewLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InsertMedia.Constants.Colors.previewLbl
        view.text = InsertMedia.Constants.Texts.previewLbl
        view.font = InsertMedia.Constants.Fonts.previewLbl
        return view
    }()
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         backButton: DefaultBackButton,
         inputTextField: UITextField,
         urlErrorView: EmptyListView,
         playerView: WKYTPlayerView,
         submitButton: UIButton) {
        self.activityView = activityView
        self.backButton = backButton
        self.inputTextField = inputTextField
        self.urlErrorView = urlErrorView
        self.playerView = playerView
        self.submitButton = submitButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsertMediaView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(backButton)
        mainContainer.addSubview(insertUrlLbl)
        mainContainer.addSubview(inputTextField)
        mainContainer.addSubview(previewLbl)
        mainContainer.addSubview(urlErrorView)
        mainContainer.addSubview(playerView)
        mainContainer.addSubview(submitButton)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.left.equalToSuperview().inset(28)
            make.height.width.equalTo(38)
        }
        insertUrlLbl.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(46)
            make.width.equalTo(165)
        }
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(insertUrlLbl.snp.bottom).offset(5)
            make.left.equalTo(insertUrlLbl)
            make.width.equalTo(321)
            make.height.equalTo(24)
        }
        previewLbl.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(42)
            make.left.equalTo(inputTextField)
            make.width.equalTo(165)
        }
        playerView.snp.makeConstraints { make in
            make.top.equalTo(previewLbl.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.width.equalTo(326)
            make.height.equalTo(221)
        }
        urlErrorView.snp.makeConstraints { make in
            make.edges.equalTo(playerView)
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(597)
            make.centerX.equalToSuperview()
            make.width.equalTo(117)
            make.height.equalTo(36)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
