//
//  SceneDelegate.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var internetErrorView: WCInternetErrorConnectionView = {
        let view = WCInternetErrorConnectionView(frame: .zero)
        view.delegate = self
        view.isHidden = true
        return view
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        InternetManager.shared.delegate = self
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()
            self.window = window
            setupMainWindowUI(window)
            let launchVC = LaunchScreenController(window: window)
            window.rootViewController = launchVC
        }
    }
    
    private func checkConnection() {
        internetErrorView.isHidden = InternetManager.shared.isNetworkAvailable
    }
    
    private func setupMainWindowUI(_ window: UIWindow) {
        window.addSubview(internetErrorView)
        internetErrorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SceneDelegate: InternetManagerDelegate {
    
    func networktUnavailable() {
        internetErrorView.isHidden = false
    }
}

extension SceneDelegate: WCInternetErrorConnectionViewDelegate {
    
    func didTapTryAgain() {
        checkConnection()
    }
}


