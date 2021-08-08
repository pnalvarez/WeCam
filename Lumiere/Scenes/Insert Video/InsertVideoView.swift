//
//  InsertMediaView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import YoutubePlayer_in_WKWebView

class InsertVideoView: BaseView, ModalViewable {

    private unowned var inputTextField: WCInputTextField
    private unowned var urlErrorView: WCEmptyListView
    private unowned var playerView: WKYTPlayerView
    private unowned var submitButton: WCPrimaryActionButton
    
    private lazy var scrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()
    
    private lazy var insertUrlLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InsertVideo.Constants.Colors.insertUrlLbl
        view.text = InsertVideo.Constants.Texts.insertUrlLbl
        view.font = InsertVideo.Constants.Fonts.insertUrlLbl
        return view
    }()
    
    private lazy var previewLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = InsertVideo.Constants.Colors.previewLbl
        view.text = InsertVideo.Constants.Texts.previewLbl
        view.font = InsertVideo.Constants.Fonts.previewLbl
        return view
    }()
    
    init(frame: CGRect,
         inputTextField: WCInputTextField,
         urlErrorView: WCEmptyListView,
         playerView: WKYTPlayerView,
         submitButton: WCPrimaryActionButton) {
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

extension InsertVideoView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        scrollView.addSubview(insertUrlLbl)
        scrollView.addSubview(inputTextField)
        scrollView.addSubview(previewLbl)
        scrollView.addSubview(urlErrorView)
        scrollView.addSubview(playerView)
        scrollView.addSubview(submitButton)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        insertUrlLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
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
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
