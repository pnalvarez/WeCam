//
//  BaseViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class BaseViewController: UIViewController {
    
    private enum Constants {
        static let navigationHiddenViewControllersCount = 1
        static let networkStatusViewHeight: CGFloat = 96
    }
    
    private let backButtonImage: UIImage = UIImage(named: "voltar 1") ?? UIImage()
    private let titleViewImage: UIImage = UIImage(named: "tipografia-projeto 2") ?? UIImage()
    
    open lazy var backButton: WCBackButton = {
        let view = WCBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    open lazy var closeButton: WCCloseButton = {
        let view = WCCloseButton(frame: .zero)
        view.associatedViewController = self
        return view
    }()
    
    private lazy var networkStatusView: NetworkStatusView = {
        let view = NetworkStatusView(frame: .zero)
        return view
    }()
    
    private lazy var internetErrorView: WCInternetErrorConnectionView = {
        let view = WCInternetErrorConnectionView(frame: .zero)
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuxiliarComponentsVisibility()
        setupUI()
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: titleViewImage)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InternetManager.shared.delegate = self
        checkConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !InternetManager.shared.isNetworkAvailable {
            networkStatusView.status = .disconnected
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(internetErrorView)
    }
    
    private func configureAuxiliarComponentsVisibility() {
        backButton.isHidden = navigationController?.viewControllers.count == Constants.navigationHiddenViewControllersCount
    }
    
    private func setupUI() {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.addSubview(internetErrorView)
        
        internetErrorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func checkConnection() {
        internetErrorView.isHidden = InternetManager.shared.isNetworkAvailable
    }
}

extension BaseViewController: WCInternetErrorConnectionViewDelegate {
    
    func didTapTryAgain() {
        checkConnection()
    }
}

extension BaseViewController: InternetManagerDelegate {
    
    func networktUnavailable() {
        internetErrorView.isHidden = false
    }
}

extension BaseViewController {
    
    @objc
    func didTap() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
