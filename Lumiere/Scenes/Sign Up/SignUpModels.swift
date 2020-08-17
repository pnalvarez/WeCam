//
//  SignUpModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

struct SignUp {
    
    static let bundle = Bundle(for: SignUpController.self)
    
    struct Constants {
        struct Colors {
            static let backgroundColor = UIColor(rgb: 0xffffff)
            static let imageButtonLayerColor = UIColor(rgb: 0xe0e0e0)
            static let textFieldBackgroundColor = UIColor(rgb: 0xededed)
            static let textFieldPlaceHolderColor = UIColor(rgb: 0x707070)
            static let cathegoriesLblColor = UIColor(rgb: 0x707070)
            static let signUpButtonBackgroundColor = UIColor(rgb: 0xe50c3c)
            static let signUpButtonDeactivatedColor = UIColor(rgb: 0xe50c3c).withAlphaComponent(0.6)
            static let signUpButtonTextColor = UIColor(rgb: 0xffffff)
            static let signUpCollectionViewCellText = UIColor(rgb: 0xffffff)
            static let textFieldColor = UIColor(rgb: 0x222222)
            static let chooseImageLbl = UIColor(rgb: 0x707070)
        }
        
        struct Texts {
            static let namePlaceholder = "Nome"
            static let cellphonePlaceholder = "Celular"
            static let emailPlaceholder = "E-mail"
            static let passwordPlaceholder = "Senha"
            static let confirmationPlaceholder = "Confirmar senha"
            static let professionalArea = "Area Profissional"
            static let cathegories = "Categorias de Interesse"
            static let signUpButton = "Cadastrar"
            static let genericError = "Ocorreu um erro genérico ao tentar cadastrar"
            static let unmatchError = "Senha e Confirmação não conferem"
            static let signUpError = "Erro no Cadastro"
            static let signUpSuccess = "Cadastro Efetivado com Sucesso"
            static let successMessage = "Usuário foi cadastrado com sucesso em nosso banco de dados"
            static let chooseImageLbl = "Escolha uma imagem"
        }
        
        struct Dimensions {
            static let mainViewHeight: CGFloat = 1150
            static let scrollViewHeigh: CGFloat = 1200
        }
        
        struct Fonts {
            static let placeholderFont = ThemeFonts.RobotoRegular(12).rawValue
            static let cathegoriesLblFont = ThemeFonts.RobotoBold(16).rawValue
            static let signUpButtonFont = ThemeFonts.RobotoRegular(12).rawValue
            static let textFieldFont = ThemeFonts.RobotoRegular(12).rawValue
            static let chooseImageLbl = ThemeFonts.RobotoRegular(14).rawValue
        }
        
        struct Images {
            static let titleHeaderIcon = UIImage(named: "tipografia-projeto 2",
                                                 in: SignUp.bundle,
                                                 compatibleWith: nil)
            static let backButton = UIImage(named: "voltar 1",
                                            in: SignUp.bundle,
                                            compatibleWith: nil)
            static let camera = UIImage(named: "photo 1",
                                        in: SignUp.bundle,
                                        compatibleWith: nil)
        }
    }
    
    struct Request {
        
        struct SelectedCathegory {
            let cathegory: MovieStyle
        }
        
        struct UserData {
            let image: UIImage?
            let name: String
            let email: String
            let password: String
            let confirmation: String
            let phoneNumber: String
            let professionalArea: String
        }
        
        struct CreateUser {
            let email: String
            let password: String
        }
        
        struct SignUpProviderRequest {
            let userData: Info.Model.UserData
            let userId: String
        }
    }
    
    struct Errors {

        enum SignUpErrors: String {
            case nameIncomplete = "Informação Incompleta: Nome"
            case nameInvalid = "Nome inválido, por favor inserir nome e sobrenome"
            case cellPhoneIncomplete = "Informação Incompleta: Celular"
            case cellPhoneInvalid = "Formato de celular inválido"
            case emailIncomplete = "Informação Incompleta: E-mail"
            case emailInvalid = "Formato de email inválido"
            case passwordIncomplete = "Informação Incompleta: Senha"
            case passwordInvalid = "Padrão de e-mail inválido"
            case confirmationIncomplete = "Por favor, confirme sua senha"
            case passwordMatch = "Inconsistência: Senha e confirmação não batem"
            case professional = "Informação Incompleta: Area profissional"
            case movieStyles = "Insira pelo menos uma categoria de interesse"
            case emailAlreadyRegistered = "Erro: O email já está cadastrado"
            case genericError = "Ocorreu um erro ao tentar cadastrar usuário, tente novamente mais tarde"
        }
        
        struct ServerError {
            let error: Error
        }
    }
    
    struct Response {
        
        enum RegisterUser {
            case success(UserResponse)
            case error(Error)
        }
        
        enum SaveUserInfo {
            case success
            case error(Error)
            case genericError
        }
        
        struct UserResponse {
            let uid: String
        }
    }
    
    struct Info {
        
        struct Model {
            
            struct UserData {
                let image: Data?
                let name: String
                let cellPhone: String
                let email: String
                let password: String
                let professionalArea: String
                let interestCathegories: InterestCathegories
            }
            
            struct InterestCathegories {
                var cathegories: [MovieStyle]
            }
        }
        
        struct ViewModel {
            
            struct Error {
                let description: String
            }
        }
    }
}
