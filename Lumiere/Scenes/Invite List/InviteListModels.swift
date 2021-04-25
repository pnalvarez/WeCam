//
//  InviteListModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
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
            static let emptyList = "Você ainda não possui amigos para convidar :("
        }
        
        struct Images {
            static let closeButton = UIImage(named: "fechar 1", in: InviteList.bundle, compatibleWith: nil)
            static let checkButtonSelected = UIImage(named: "icone-usuario-participante", in: InviteList.bundle, compatibleWith: nil)
            static let checkButtonUnselected = UIImage(named: "icone-check 1", in: InviteList.bundle, compatibleWith: nil)
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
            
            struct Connections: Equatable {
                var users: [User]
            }
        
            struct User: Equatable {
                let id: String
                let image: String?
                let name: String
                let email: String
                let ocupation: String
                var inviting: Bool
            }
        }
        
        struct ViewModel {
            
            struct Connections: Equatable {
                let users: [User]
            }
            
            struct User: Equatable {
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

extension InviteList.Info.Response.User: MultipleStubbable {
    static var stubArray: [InviteList.Info.Response.User] {
        return [InviteList.Info.Response.User(JSONString: """
                    {
                        "userId": "idUser1",
                        "name": "Usuario Teste 1",
                        "image": "image",
                        "ocupation": "Artista",
                        "email": "user_test1@hotmail.com"
                    }
                """)!,
                InviteList.Info.Response.User(JSONString: """
                            {
                                "userId": "idUser2",
                                "name": "Usuario Teste 2",
                                "image": "image",
                                "ocupation": "Artista",
                                "email": "user_test2@hotmail.com"
                            }
                        """)!]
    }
}

extension InviteList.Info.Model.Connections: Stubbable{
    static var stub: InviteList.Info.Model.Connections {
        return InviteList.Info.Model.Connections(users: [InviteList.Info.Model.User(id: "idUser1", image: "image", name: "Usuario Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: false), InviteList.Info.Model.User(id: "idUser2", image: "image", name: "Usuario Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista", inviting: false)])
    }
}
