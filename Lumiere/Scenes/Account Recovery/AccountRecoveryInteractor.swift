//
//  AccountRecoveryInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol AccountRecoveryBusinessLogic {
    func searchUser(_ request: AccountRecovery.Request.SearchAccount)
    func sendRecoveryEmail(_ request: AccountRecovery.Request.SendEmail)
}

protocol AccountRecoveryDataStore: class {
    var userData: AccountRecovery.Info.Model.Account? { get }
}

class AccountRecoveryInteractor: AccountRecoveryDataStore {
    
    private let worker: AccountRecoveryWorkerProtocol
    private let presenter: AccountRecoveryPresentationLogic
    
    var userData: AccountRecovery.Info.Model.Account?
    
    init(worker: AccountRecoveryWorkerProtocol = AccountRecoveryWorker(),
         presenter: AccountRecoveryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    private func checkEmailFormat(_ email: String) -> Bool {
        return true
    }
}

extension AccountRecoveryInteractor: AccountRecoveryBusinessLogic {

    func searchUser(_ request: AccountRecovery.Request.SearchAccount) {
        presenter.presentLoading(true)
        guard checkEmailFormat(request.email) else {
            self.presenter.presentLoading(false)
            self.presenter.presentError(AccountRecovery.Info.Model.Error(title: AccountRecovery.Constants.Texts.emailFormatErrorTitle, message: AccountRecovery.Constants.Texts.emailFormatErrorMessage))
            return
        }
        worker.fetchUserData(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.userData = AccountRecovery.Info.Model.Account(userId: data.userId ?? .empty, name: data.name ?? .empty, image: data.image ?? .empty, phone: data.phone ?? .empty, email: data.email ?? .empty, ocupation: data.ocupation ?? .empty)
                guard let user = self.userData else { return }
                self.presenter.presentUserResult(user)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(AccountRecovery.Info.Model.Error(title: AccountRecovery.Constants.Texts.genericErrorTitle, message: error.localizedDescription))
            }
        }
    }
    
    func sendRecoveryEmail(_ request: AccountRecovery.Request.SendEmail) {
        presenter.presentLoading(true)
        worker.fetchSendRecoveryEmail(AccountRecovery.Request.SendRecoveryEmail(email: userData?.email ?? .empty)) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentSuccessfullySentEmailAlert()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(AccountRecovery.Info.Model.Error(title: AccountRecovery.Constants.Texts.genericErrorTitle, message: error.localizedDescription))
            }
        }
    }
}
