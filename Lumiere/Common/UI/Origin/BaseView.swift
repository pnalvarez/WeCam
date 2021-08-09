//
//  BaseView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 01/05/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class BaseView: UIView {
    
    private enum Constants {
        static let navigationHiddenViewControllersCount = 1
        static let horizontalMargin: CGFloat = 24
        static let verticalMargin: CGFloat = 8
    }
    
    open lazy var backButton: WCBackButton = {
        let view = WCBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    open lazy var closeButton: WCCloseButton = {
        let view = WCCloseButton(frame: .zero)
        view.associatedViewController = parentViewController
        return view
    }()
    
    open lazy var primaryActivityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        view.hidesWhenStopped = true
        view.isHidden = true
        return view
    }()
    
    private lazy var secondaryActivityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        view.hidesWhenStopped = true
        view.isHidden = true
        return view
    }()
    
    private lazy var loadingView: WCLoadingView = {
        let view = WCLoadingView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        backgroundColor = .white
    }
    
    func setupAuxiliarComponentsVisibility(backButtonVisible: Bool, closeButtonVisible: Bool) {
        backButton.isHidden = !backButtonVisible
        closeButton.isHidden = !closeButtonVisible
    }
    
    func defaultScreenLoading(_ hide: Bool) {
        if hide {
            primaryActivityView.stopAnimating()
        } else {
            primaryActivityView.startAnimating()
            primaryActivityView.isHidden = false
        }
    }
    
    func defaultSubviewLoading(_ hide: Bool, forIdentifier identifier: String) {
        if let view = subviews.first(where: { $0.accessibilityLabel == identifier }) {
            if !view.contains(secondaryActivityView) {
                setupSecondaryActivityUI(in: view)
            }
            configureSecondaryActivity(hide)
        }
    }
    
    func fullScreenLoading(_ hide: Bool) {
        if hide {
            loadingView.isHidden = true
            loadingView.stopRotate()
        } else {
            loadingView.isHidden = false
            loadingView.animateRotate()
        }
    }
    
    @objc
    private func didTapBack() {
        parentViewController?.navigationController?.popViewController(animated: true)
    }
    
    func configureAuxiliarComponentsVisibility() {
        guard let stackCount = parentViewController?.navigationController?.viewControllers.count else {
            backButton.isHidden = true
            return
        }
        backButton.isHidden = stackCount == Constants.navigationHiddenViewControllersCount
    }
    
    private func configureSecondaryActivity(_ hide: Bool) {
        if hide {
            secondaryActivityView.stopAnimating()
        } else {
            secondaryActivityView.startAnimating()
            secondaryActivityView.isHidden = false
        }
    }
    
    private func setupSecondaryActivityUI(in view: UIView) {
        addSubview(secondaryActivityView)
        secondaryActivityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        addSubview(primaryActivityView)
        addSubview(loadingView)
        if let scrollView = subviews.first(where: { $0 is UIScrollView }),
           let container = scrollView.subviews.first(where: { $0 is WCContentView }) {
            container.addSubview(backButton)
            
            backButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Constants.verticalMargin)
                make.left.equalToSuperview().inset(Constants.horizontalMargin)
            }
            
            if self is ModalViewable {
                container.addSubview(closeButton)
                closeButton.snp.makeConstraints { make in
                    make.top.equalTo(backButton)
                    make.right.equalToSuperview().inset(Constants.horizontalMargin)
                }
            }
        } else {
            addSubview(backButton)
            
            backButton.snp.makeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Constants.verticalMargin)
                make.left.equalToSuperview().inset(Constants.horizontalMargin)
            }
            
            if self is ModalViewable {
                addSubview(closeButton)
                closeButton.snp.makeConstraints { make in
                    make.top.equalTo(backButton)
                    make.right.equalToSuperview().inset(Constants.horizontalMargin)
                }
            }
        }
        primaryActivityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
