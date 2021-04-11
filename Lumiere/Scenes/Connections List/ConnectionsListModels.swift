//
//  ConnectionsListModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit
import ObjectMapper

struct ConnectionsList {
    
    struct Constants {
        
        struct Colors {
            static let photoImageView = UIColor(rgb: 0xc4c4c4).cgColor
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let background = UIColor(rgb: 0xffffff)
            static let removeButtonBackground = UIColor(rgb: 0xc4c4c4)
            static let removeButtonLayer = UIColor(rgb: 0xe50c3c).cgColor
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
            static let error = "Erro"
        }
        
        struct Dimensions {
            
            struct Heights {
                static let connectionTableCell: CGFloat = 104
            }
        }
        
        struct Images {
            static let back = UIImage(named: "voltar 1")
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct User {
                let id: String
                let name: String
                let userType: Model.UserType
            }
        }
        
        struct Model {
            
            struct User {
                let id: String
            }
            
            enum UserType {
                case logged
                case other
            }
            
            struct CurrentUser {
                let id: String
                let name: String
            }
            
            struct UserConnections {
                var userType: UserType
                var connections: [Connection]
            }
            
            struct Connection {
                let userId: String
                let image: String?
                let name: String
                let ocupation: String
            }
            
            struct UserProfileDetails {
                let userId: String
                let image: String?
                let name: String
                let ocupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: Int
                let progressingProjects: [String]
                let finishedProjects: [String]
            }
            
            struct SelectedUser {
                let id: String
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
                let removeOptionActive: Bool
                let connections: [Connection]
            }
        }
        
        struct Response {
            
            final class CurrentUser: Mappable {
                
                var id: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                }
            }
            
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
            
            final class ProfileDetails: Mappable {
                
                var name: String?
                var email: String?
                var ocupation: String?
                var phoneNumber: String?
                var image: String?
                var connectionsCount: Int?
                
                init?(map: Map) {}
                           
                func mapping(map: Map) {
                    name <- map["name"]
                    email <- map["email"]
                    ocupation <- map["professional_area"]
                    phoneNumber <- map["phone_number"]
                    image <- map["profile_image_url"]
                    connectionsCount <- map["connections_count"]
                }
            }
        }
    }
    
    struct Request {
        
        struct FetchCurrentUser {
            
        }
        
        struct FetchConnections {
            
        }
        
        struct FetchUserDetails {
            
        }
        
        struct FetchProfileDetails {
            let index: Int
        }
        
        struct FetchRemoveConnection {
            let index: Int
        }
        
        struct FetchRemoveConnectionWithId {
            let userId: String
        }
        
        struct FetchProfileDetailsWithId {
            let userId: String
        }
        
        struct FetchConnectionsWithId {
            let userId: String
        }
    }
    
    struct Errors {
        
        struct Model {
            let error: WCError
        }
        
        struct ViewModel {
            let description: String
        }
    }
}
