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
    }
    
    private func setupUI() {
        view.addSubview(internetErrorView)
        
        internetErrorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func didTap() {
        view.endEditing(true)
    }
}

extension BaseTableViewController: WCInternetErrorConnectionViewDelegate {
    
    func didTapTryAgain() {
        if InternetManager.shared.isNetworkAvailable {
            internetErrorView.isHidden = true
        }
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
