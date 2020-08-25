//
//  InviteListModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct InviteList {
    
    static let bundle = Bundle(for: InviteListController.self)
    
    struct Constants {
        
        struct Colors {
            static let inviteLbl = UIColor(rgb: 0x707070)
            static let searchTextFieldBackground = UIColor(rgb: 0xffffff)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let nameLblCell = UIColor(rgb: 0x000000)
            static let ocupationLblCell = UIColor(rgb: 0x000000)
            static let emailLblCell = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let inviteLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let nameLblCell = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLblCell = ThemeFonts.RobotoRegular(16).rawValue
            static let emailLblCell = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let inviteLbl = "Convidar amigos"
        }
        
        struct Images {
            static let closeButton = UIImage(named: "fechar 1", in: InviteList.bundle, compatibleWith: nil)
            static let checkButtonSelected = UIImage(named: "icone-conexao-feita 1", in: InviteList.bundle, compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let tableCell: CGFloat = 120
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct InvitedUsers {
                let users: [User]
            }
            
            struct User {
                let id: String
            }
        }
        
        struct Model {
            
            struct Connections {
                var users: [User]
            }
        
            struct User {
                let id: String
                let image: String?
                let name: String
                let email: String
                let ocupation: String
                var inviting: Bool
            }
        }
        
        struct ViewModel {
            
            struct Connections {
                let users: [User]
            }
            
            struct User {
                let name: String
                let image: String?
                let email: String
                let ocupation: String
                let inviting: Bool
            }
        }
        
        struct Response {
            
            final class User: Mappable {
                
                var id: String?
                var name: String?
                var image: String?
                var ocupation: String?
                var email: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["userId"]
                    name <- map["name"]
                    image <- map["image"]
                    ocupation <- map["ocupation"]
                    email <- map["email"]
                }
            }
        }
    }
    
    struct Request {
        
        struct FetchConnections {
            
        }
        
        struct SelectUser {
            let index: Int
        }
        
        struct Search {
            let preffix: String
        }
        
        struct SendInvites {
            let users: String
        }
    }
}
