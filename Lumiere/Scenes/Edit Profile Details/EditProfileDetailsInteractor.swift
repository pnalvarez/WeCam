//
//  EditProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProfileDetailsBusinessLogic {
    func fetchUserData(request: EditProfileDetails.Request.UserData)
}

protocol EditProfileDetailsDataStore {
    var userData: EditProfileDetails.Info.Model.User? { get set }
}

class EditProfileDetailsInteractor: EditProfileDetailsDataStore {
    
    private let worker: EditProfileDetailsWorkerProtocol
    var presenter: EditProfileDetailsPresentationLogic
    
    var userData: EditProfileDetails.Info.Model.User?
    
    init(worker: EditProfileDetailsWorkerProtocol = EditProfileDetailsWorker(),
         viewController: EditProfileDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = EditProfileDetailsPresenter(viewController: viewController)
    }
}

extension EditProfileDetailsInteractor {
    
    private func buildInterestCathegories(cathegories: [String]) -> EditProfileDetails.Info.Model.InterestCathegories {
        var interestCathegories = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [])
        for style in MovieStyle.toArray() {
            if cathegories.contains(style.rawValue) {
                interestCathegories.cathegories.append(EditProfileDetails.Info.Model.Cathegory(style: style, selected: true))
            } else {
                interestCathegories.cathegories.append(EditProfileDetails.Info.Model.Cathegory(style: style, selected: false))
            }
        }
        return interestCathegories
    }
}

extension EditProfileDetailsInteractor: EditProfileDetailsBusinessLogic {
    
    func fetchUserData(request: EditProfileDetails.Request.UserData) {
        presenter.presentLoading(true)
        worker.fetchUserData(request: request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.userData = EditProfileDetails.Info.Model.User(id: data.id ?? .empty,
                                                                   image: data.image,
                                                                   name: data.name ?? .empty,
                                                                   cellphone: data.cellphone ?? .empty,
                                                                   ocupation: data.ocupation ?? .empty,
                                                                   interestCathegories: self.buildInterestCathegories(cathegories: data.interestCathegories ?? .empty))
                guard let user = self.userData else { return }
                self.presenter.presentUserData(user)
                break
            case .error(let error):
                break
            }
        }
    }
}
