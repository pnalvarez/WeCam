//
//  InsertMediaController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

protocol InsertMediaDisplayLogic: class {
    
}

class InsertMediaController: BaseViewController {
    
    private lazy var playerView: WKYTPlayerView = {
        let view = WKYTPlayerView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private var interactor: InsertMediaBusinessLogic?
    var router: InsertMediaRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setup() {
        let viewController = self
        let presenter = InsertMediaPresenter(viewController: viewController)
        let interactor = InsertMediaInteractor(presenter: presenter)
        let router = InsertMediaRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension InsertMediaController: WKYTPlayerViewDelegate {
    
}

extension InsertMediaController: InsertMediaDisplayLogic {
    
}
