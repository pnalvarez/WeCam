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
    
    private let allCathegories = WCMovieStyle.toArray()
    
    init(viewController: SignUpDisplayLogic,
         provider: SignUpProviderProtocol = SignUpProvider()) {
        self.presenter = SignUpPresenter(viewController: viewController)
        self.provider = SignUpProvider()
    }
}

extension SignUpInteractor {
    
    private func checkErrors(with request: SignUp.Request.UserData) -> SignUp.Errors.UpcomingErrors {
        var inputErrors = [SignUp.Errors.SignUpErrors]()
        if request.name.isEmpty {
            inputErrors.append(.nameIncomplete)
        }
        if request.name.split(separator: Character(.space)).count <= 1 {
            inputErrors.append(.nameInvalid)
        }
        if request.phoneNumber.isEmpty {
            inputErrors.append(.cellPhoneIncomplete)
        }
        if request.phoneNumber.count != SignUp.Constants.BusinessLogic.phoneNumberCount {
            inputErrors.append(.cellPhoneInvalid)
        }
        if request.email.isEmpty {
            inputErrors.append(.emailIncomplete)
        }
        if !request.email.isValidEmail() {
            inputErrors.append(.emailInvalid)
        }
        if request.password.isEmpty {
            inputErrors.append(.passwordIncomplete)
        }
        if request.confirmation.isEmpty {
            inputErrors.append(.confirmationIncomplete)
        }
        if request.password != request.confirmation {
            inputErrors.append(.passwordMatch)
        }
        if request.professionalArea.isEmpty {
            inputErrors.append(.professional)
        }
        if interestCathegories.cathegories.isEmpty {
            inputErrors.append(.movieStyles)
        }
        return SignUp.Errors.UpcomingErrors(errors: inputErrors)
    }
}

extension SignUpInteractor: SignUpBusinessLogic {
    
    func fetchMovieStyles() {
           let allStyles = WCMovieStyle.toArray()
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
        let inputErrors = checkErrors(with: request)
        guard inputErrors.errors.isEmpty else {
            presenter.presentErrors(inputErrors)
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
