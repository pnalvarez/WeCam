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

class InsertVideoView: BaseView {

    private unowned var confirmationAlertView: ConfirmationAlertView
    private unowned var translucentView: UIView
    private unowned var inputTextField: UITextField
    private unowned var urlErrorView: WCEmptyListView
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
    
    private lazy var mainContainer: WCContentView = {
        let view = WCContentView(frame: .zero)
        view.style = .white
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
         confirmationAlertView: ConfirmationAlertView,
         translucentView: UIView,
         inputTextField: UITextField,
         urlErrorView: WCEmptyListView,
         playerView: WKYTPlayerView,
         submitButton: UIButton) {
        self.confirmationAlertView = confirmationAlertView
        self.translucentView = translucentView
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
    
    func displayConfirmationModal() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = false
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.centerY)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
    func hideConfirmationModal() {
        UIView.animate(withDuration: 0.2, animations: {
            self.translucentView.isHidden = true
            self.confirmationAlertView.snp.remakeConstraints { make in
                make.top.equalTo(self.translucentView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.translucentView)
            }
            self.layoutIfNeeded()
        })
    }
    
}

extension InsertVideoView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        mainContainer.addSubview(insertUrlLbl)
        mainContainer.addSubview(inputTextField)
        mainContainer.addSubview(previewLbl)
        mainContainer.addSubview(urlErrorView)
        mainContainer.addSubview(playerView)
        mainContainer.addSubview(submitButton)
        scrollView.addSubview(mainContainer)
        addSubview(scrollView)
        addSubview(translucentView)
        addSubview(confirmationAlertView)
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
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        confirmationAlertView.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom)
            make.size.equalTo(translucentView)
        }
    }
}
