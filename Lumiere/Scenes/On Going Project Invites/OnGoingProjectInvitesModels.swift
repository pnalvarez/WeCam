//
//  OnGoingProjectInvitesModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct OnGoingProjectInvites {
    
    static let bundle = Bundle(for: OnGoingProjectInvitesController.self)
    
    struct Constants {
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            
        }
        
        struct Images {
            static let invite = UIImage(named: "icone-usuario-sem-relacao-com-o-projeto 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let member = UIImage(named: "icone-conexao-feita 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let receivedRequest = UIImage(named: "icone-pendente 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let sentRequest = UIImage(named: "pendente 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
        }
    }
    
    struct Info {
        
        struct Received {
            
        }
        
        struct Model {
            
        }
        
        struct ViewModel {
            
            enum Relation {
                case simpleParticipant
                case receivedRequest
                case sentRequest
                case nothing
            }
            
            struct User {
                let index: Int
                let image: String
                let name: String
                let ocupation: String
                let email: NSAttributedString
                let relation: Relation
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
    }
}
