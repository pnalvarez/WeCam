//
//  EditProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProfileDetailsBusinessLogic {
    func fetchUserData(_ request: EditProfileDetails.Request.UserData)
    func didSelectCathegory(_ request: EditProfileDetails.Request.SelectCathegory)
    func fetchFinish(_ request: EditProfileDetails.Request.Finish)
}

protocol EditProfileDetailsDataStore {
    var userData: EditProfileDetails.Info.Model.User? { get set }
}

class EditProfileDetailsInteractor: EditProfileDetailsDataStore {
    
    private let worker: EditProfileDetailsWorkerProtocol
    var presenter: EditProfileDetailsPresentationLogic
    
    var userData: EditProfileDetails.Info.Model.User?
    var cathegoriesData: EditProfileDetails.Info.Model.InterestCathegories?
    
    init(worker: EditProfileDetailsWorkerProtocol = EditProfileDetailsWorker(),
         presenter: EditProfileDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
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
    
    private func checkErrors(_ request: EditProfileDetails.Request.Finish) -> Bool {
        guard !request.name.isEmpty else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.emptyName)
            return true
        }
        guard request.name.split(separator: Character(.space)).count > 1 else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.singleWordName)
            return true
        }
        guard !request.cellphone.isEmpty else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.emptyCellphone)
            return true
        }
        guard request.cellphone.count == 15 else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.cellphoneInvalid)
            return true
        }
        guard !request.ocupation.isEmpty else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.emptyOcupation)
            return true
        }
        guard !(userData?.interestCathegories.cathegories.filter({$0.selected}).isEmpty ?? false) else {
            presenter.presentLoading(false)
            presenter.presentInputError(EditProfileDetails.Errors.InputErrors.emptyInterestCathegories)
            return true
        }
        return false
    }
}

extension EditProfileDetailsInteractor: EditProfileDetailsBusinessLogic {
    
    func fetchUserData(_ request: EditProfileDetails.Request.UserData) {
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
                self.presenter.presentLoading(false)
                self.presenter.presentServerError(error)
                break
            }
        }
    }
    
    func didSelectCathegory(_ request: EditProfileDetails.Request.SelectCathegory) {
        guard let cathegory = userData?.interestCathegories.cathegories[request.index] else { return }
        userData?.interestCathegories.cathegories[request.index].selected = !cathegory.selected
        guard let user = userData else { return }
        presenter.presentCathegories(user.interestCathegories)
    }
    
    func fetchFinish(_ request: EditProfileDetails.Request.Finish) {
        self.presenter.presentLoading(true)
        guard !checkErrors(request) else {
            return
        }
        let cathegories = userData?.interestCathegories.cathegories
        let request = EditProfileDetails.Request.UpdateUser(image: request.image,
                                                            name: request.name,
                                                            cellphone: request.cellphone,
                                                            ocupation: request.ocupation,
                                                            interestCathegories: cathegories?.filter({ $0.selected }).map({$0.style.rawValue}) ?? .empty)
        worker.fetchUpdateUserDetails(request: request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.didUpdateUser()
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentServerError(error)
                break
            }
        }
    }
}
