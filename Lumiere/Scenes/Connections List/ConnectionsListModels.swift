//
//  ConnectionsListModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import ObjectMapper

struct ConnectionsList {
    
    struct Constants {
        
        struct Colors {
            static let photoImageView = UIColor(rgb: 0xc4c4c4).cgColor
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let background = UIColor(rgb: 0xffffff)
            static let removeButtonBackground = UIColor(rgb: 0xc4c4c4)
            static let removeButtonLayer = UIColor(rgb: 0xe5dfdf).cgColor
            static let removeButtonText = UIColor(rgb: 0x000000)
            static let nameHeaderLbl = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let removeButton = ThemeFonts.RobotoRegular(16).rawValue
            static let nameHeaderLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let removeButton = "Remover"
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct User {
                let name: String
            }
        }
        
        struct Model {
            
            struct CurrentUser {
                let name: String
            }
            
            struct UserConnections {
                var connections: [Connection]
            }
            
            struct Connection {
                let userId: String
                let image: String?
                let name: String
                let ocupation: String
            }
            
        }
        
        struct ViewModel {
            
            struct CurrentUser {
                let name: String
            }
            
            struct Connection {
                let image: String?
                let name: String
                let ocupation: String
            }
            
            struct UpcomingConnections {
                let connections: [Connection]
            }
        }
        
        struct Response {
            
            final class Connection: Mappable {
                
                var name: String?
                var ocupation: String?
                var image: String?
                var userId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    name <- map["name"]
                    ocupation <- map["ocupation"]
                    image <- map["image"]
                    userId <- map["userId"]
                }
            }
        }
    }
    
    struct Request {
        
        struct FetchConnections {
            
        }
        
        struct FetchUserDetails {
            
        }
        
        struct FetchProfileDetails {
            
        }
        
        struct FetchRemoveConnection {
            let index: Int
        }
        
        struct FetchRemoveConnectionWithId {
            let userId: String
        }
    }
    
    struct Errors {
        
    }
}
