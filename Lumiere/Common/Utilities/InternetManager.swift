//
//  InternetManager.swift
//  WeCam
//
//  Created by Pedro Alvarez on 20/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import Network

protocol InternetManagerDelegate: class {
    func networkAvailable()
    func networktUnavailable()
}

open class InternetManager {
    
    static let shared = InternetManager()
    
    private let monitor = NWPathMonitor()
    private let queueLabel = "Monitor"
    
    weak var delegate: InternetManagerDelegate?
    
    private(set) var isNetworkAvailable: Bool = true {
        didSet {
            if isNetworkAvailable {
                delegate?.networkAvailable()
            } else {
                delegate?.networktUnavailable()
            }
        }
    }
    
    private init() { }
    
    func setupInternetMonitor() {
        monitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                self.isNetworkAvailable = true
            default:
                self.isNetworkAvailable = false
            }
        }
        let queue = DispatchQueue(label: queueLabel)
        monitor.start(queue: queue)
    }
}
