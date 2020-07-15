//
//  SignUpInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignUpBusinessLogic {
    func fetchMovieStyles()
    func didSelectCathegory(_ request: SignUp.Request.SelectedCathegory)
}

protocol SignUpDataStore {
    var userData: SignUp.Info.Data.UserData? { get set }
    var interestCathegories: SignUp.Info.Data.InteretCathegories { get set }
}

class SignUpInteractor: SignUpDataStore {
    
    var presenter: SignUpPresentationLogic
    var provider: SignUpProviderProtocol
    
    var userData: SignUp.Info.Data.UserData?
    var interestCathegories: SignUp.Info.Data.InteretCathegories = SignUp.Info.Data.InteretCathegories(cathegories: [])
    
    init(viewController: SignUpDisplayLogic,
         provider: SignUpProviderProtocol = SignUpProvider()) {
        self.presenter = SignUpPresenter(viewController: viewController)
        self.provider = SignUpProvider()
    }
}

extension SignUpInteractor: SignUpBusinessLogic {
    
    func fetchMovieStyles() {
           let allStyles = MovieStyle.toArray()
           presenter.didFetchMovieStyles(allStyles)
       }
    
    func didSelectCathegory(_ request: SignUp.Request.SelectedCathegory) {
        guard let index = interestCathegories.cathegories.firstIndex(where:{ $0 == request.cathegory }) else  {
            interestCathegories.cathegories.append(request.cathegory)
            return
        }
        interestCathegories.cathegories.remove(at: index)
    }
}
