//
//  BaseViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private enum Constants {
        static let navigationHiddenViewControllersCount = 1
    }
    
    private let backButtonImage: UIImage = UIImage(named: "voltar 1") ?? UIImage()
    private let titleViewImage: UIImage = UIImage(named: "tipografia-projeto 2") ?? UIImage()
    
    open lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    open lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.associatedViewController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuxiliarComponentsVisibility()
        navigationItem.backBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: titleViewImage)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InternetManager.shared.delegate = self
    }
    
    private func configureAuxiliarComponentsVisibility() {
        backButton.isHidden = navigationController?.viewControllers.count == Constants.navigationHiddenViewControllersCount
        closeButton.isHidden = navigationController != nil
    }
}

extension BaseViewController: InternetManagerDelegate {
    
    func networkAvailable() {
        //TO DO
    }
    
    func networktUnavailable() {
        //TO DO
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
