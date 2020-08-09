//
//  ConnectionsListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListWorkerProtocol {
    
}

class ConnectionsListWorker: ConnectionsListWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init() {
        self.builder = FirebaseAuthHelper()
    }
}
