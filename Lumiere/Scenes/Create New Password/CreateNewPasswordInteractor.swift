//
//  CreateNewPasswordInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol CreateNewPasswordBusinessLogic {
    func submitNewPassword(_ request: CreateNewPassword.Request.Submit)
}

protocol CreateNewPasswordDataStore: class {
    var receivedAccount: CreateNewPassword.Info.Received.Account? { get set }
}

class CreateNewPasswordInteractor: CreateNewPasswordDataStore {
    
    private let worker: CreateNewPasswordWorkerProtocol
    private let presenter: CreateNewPasswordPresentationLogic
    
    var receivedAccount: CreateNewPassword.Info.Received.Account?
    
    init(worker: CreateNewPasswordWorkerProtocol = CreateNewPasswordWorker(),
         presenter: CreateNewPasswordPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    private func checkErrors(password: String, confirmation: String) -> Bool {
        guard !password.isEmpty else {
            presenter.presentError(CreateNewPassword.Info.Model.Error(type: .passwordFormat, title: CreateNewPassword.Constants.Texts.passwordEmptyErrorTitle, message: CreateNewPassword.Constants.Texts.passwordEmptyErrorMessage))
            return false
        }
        guard password == confirmation else {
            presenter.presentError(CreateNewPassword.Info.Model.Error(type: .passwordMatch, title: CreateNewPassword.Constants.Texts.passwordMatchErrorTitle, message: CreateNewPassword.Constants.Texts.passwordMatchErrorMessage))
            return false
        }
        return true
    }
}

extension CreateNewPasswordInteractor: CreateNewPasswordBusinessLogic {
    
    func submitNewPassword(_ request: CreateNewPassword.Request.Submit) {
        presenter.presentLoading(true)
        guard checkErrors(password: request.password, confirmation: request.confirmation) else {
            presenter.presentLoading(false)
            return
        }
        worker.fetchChangePassword(CreateNewPassword.Request.ChangePassword(userId: receivedAccount?.userId ?? .empty, password: request.password)) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentSuccessAlert()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(CreateNewPassword.Info.Model.Error(type: .server, title: CreateNewPassword.Constants.Texts.genericErrorTitle, message: error.localizedDescription))
            }
        }
    }
}
