//
//  ProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileDetailsBusinessLogic {
    func fetchUserData(_ request: ProfileDetails.Request.UserData)
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection)
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections)
}

protocol ProfileDetailsDataStore {
    var userData: ProfileDetails.Info.Received.User? { get set }
}

class ProfileDetailsInteractor: ProfileDetailsDataStore {
    
    var presenter: ProfileDetailsPresentationLogic
    var worker: ProfileDetailsWorkerProtocol
    
    var userData: ProfileDetails.Info.Received.User?
    
    init(viewController: ProfileDetailsDisplayLogic,
         worker: ProfileDetailsWorkerProtocol = ProfileDetailsWorker()) {
        self.presenter = ProfileDetailsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
    func fetchUserData(_ request: ProfileDetails.Request.UserData) {
        let response = ProfileDetails.Info.Model.User(id: userData?.id ?? .empty,
                                                      image: userData?.image,
                                                      name: userData?.name ?? .empty,
                                                      occupation: userData?.occupation ?? .empty,
                                                      email: userData?.email ?? .empty,
                                                      phoneNumber: userData?.phoneNumber ?? .empty,
                                                      connectionsCount: userData?.connectionsCount ?? 0,
                                                      progressingProjects: [],
                                                      finishedProjects: [])
        presenter.presentUserInfo(response)
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection) {
        //TO DO
    }
    
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections) {
        //TO DO
    }
}

