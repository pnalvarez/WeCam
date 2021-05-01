//
//  BaseTableViewController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 30/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class BaseTableViewController: UITableViewController {
    
    private lazy var internetErrorView: WCInternetErrorConnectionView = {
        let view = WCInternetErrorConnectionView(frame: .zero)
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.isNavigationBarHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InternetManager.shared.delegate = self
        checkConnection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.bringSubviewToFront(internetErrorView)
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
    
    @objc
    private func didTap() {
        view.endEditing(true)
    }
}

extension BaseTableViewController: WCInternetErrorConnectionViewDelegate {
    
    func didTapTryAgain() {
        checkConnection()
    }
}

extension BaseTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BaseTableViewController: InternetManagerDelegate {
    
    func networktUnavailable() {
        internetErrorView.isHidden = false
    }
}
