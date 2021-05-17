//
//  SignUpInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol SignUpBusinessLogic {
    func fetchMovieStyles()
    func didSelectCathegory(_ request: SignUp.Request.SelectedCathegory)
    func fetchSignUp(_ request: SignUp.Request.UserData)
}

protocol SignUpDataStore {
    var userData: SignUp.Info.Model.UserData? { get set }
    var interestCathegories: SignUp.Info.Model.InterestCathegories { get set }
}

class SignUpInteractor: SignUpDataStore {
    
    var presenter: SignUpPresentationLogic
    var provider: SignUpProviderProtocol
    
    var userData: SignUp.Info.Model.UserData?
    var interestCathegories: SignUp.Info.Model.InterestCathegories = SignUp.Info.Model.InterestCathegories(cathegories: [])
    
    private let allCathegories = MovieStyle.toArray()
    
    init(viewController: SignUpDisplayLogic,
         provider: SignUpProviderProtocol = SignUpProvider()) {
        self.presenter = SignUpPresenter(viewController: viewController)
        self.provider = SignUpProvider()
    }
}

extension SignUpInteractor {
    
    private func checkErrors(with request: SignUp.Request.UserData) -> Bool{
        guard !request.name.isEmpty else {
            presenter.presentError(.nameIncomplete)
            return true
        }
        guard request.name.split(separator: Character(.space)).count > 1 else {
            presenter.presentError(.nameInvalid)
            return true
        }
        guard !request.phoneNumber.isEmpty else {
            presenter.presentError(.cellPhoneIncomplete)
            return true
        }
        guard request.phoneNumber.count == 15 else {
            presenter.presentError(.cellPhoneInvalid)
            return true
        }
        guard !request.email.isEmpty else {
            presenter.presentError(.emailIncomplete)
            return true
        }
        guard request.email.isValidEmail() else {
            presenter.presentError(.emailInvalid)
            return true
        }
        guard !request.password.isEmpty else {
            presenter.presentError(.passwordIncomplete)
            return true
        }
        guard !request.confirmation.isEmpty else {
            presenter.presentError(.confirmationIncomplete)
            return true
        }
        guard request.password == request.confirmation else {
            presenter.presentError(.passwordMatch)
            return true
        }
        guard !request.professionalArea.isEmpty else {
            presenter.presentError(.professional)
            return true
        }
        guard interestCathegories.cathegories.count > 0 else {
            presenter.presentError(.movieStyles)
            return true
        }
        return false
    }
}

extension SignUpInteractor: SignUpBusinessLogic {
    
    func fetchMovieStyles() {
           let allStyles = MovieStyle.toArray()
           presenter.didFetchMovieStyles(allStyles)
       }
    
    func didSelectCathegory(_ request: SignUp.Request.SelectedCathegory) {
        let selectedCathegory = allCathegories[request.index]
        guard let index = interestCathegories.cathegories.firstIndex(where:{ $0 == selectedCathegory }) else  {
            interestCathegories.cathegories.append(selectedCathegory)
            return
        }
        interestCathegories.cathegories.remove(at: index)
    }
    
    func fetchSignUp(_ request: SignUp.Request.UserData) {
        guard !checkErrors(with: request) else {
            return
        }
        presenter.presentLoading(true)
        userData = SignUp.Info.Model.UserData(image: request.image?.jpegData(compressionQuality: 0.5),
                                             name: request.name,
                                             cellPhone: request.phoneNumber,
                                             email: request.email,
                                             password: request.password,
                                             professionalArea: request.professionalArea,
                                             interestCathegories: interestCathegories)
        let registerUserRequest = SignUp.Request.RegisterUser(image: request.image?.jpegData(compressionQuality: 0.5), name: request.name, email: request.email, password: request.password, confirmation: request.confirmation, phoneNumber: request.phoneNumber, ocupation: request.professionalArea, interestCathegories: interestCathegories.cathegories.map({ $0.rawValue }))
        
        provider.registerUser(registerUserRequest) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.presenter.didSignUpUser()
            case .error(let error):
                self.presenter.didFetchServerError(SignUp.Errors.ServerError(error: error))
            }
        }
    }
}
