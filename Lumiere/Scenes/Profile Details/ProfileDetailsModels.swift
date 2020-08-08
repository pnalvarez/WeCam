//
//  ProfileDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import ObjectMapper

struct ProfileDetails {
    
    struct Constants {
        
        struct Colors {
            static let allConnectionsButton = UIColor(rgb: 0xe50c3c)
            static let nameLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let phoneNumberLbl = UIColor(rgb: 0x000000)
            static let allConnectionsButtonText = UIColor(rgb: 0xffffff)
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let phoneNumberLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let allConnectionsButton = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Images {
            static let backButton = UIImage(named: "voltar 1")
            static let add = UIImage(named: "+")
            static let isConnection = UIImage(named: "icone-conexao-feita 1")
            static let pending = UIImage(named: "pendente 1")
        }
        
        struct Texts {
            static let addConnectionError = "Erro ao tentar adicionar conexão"
            static let genericError = "Ocorreu um erro genérico"
        }
    }
    
    struct Info {
        
        enum ConnectionType {
            case contact
            case sent
            case pending
            case nothing
        }
        
        struct Received {
            
            struct User {
                let connectionType: ConnectionType
                let id: String
                let image: String?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: String
                let progressingProjectsIds: [String]
                let finishedProjectsIds: [String]
            }
        }
        
        struct Model{
            
            struct User {
                let connectionType: ConnectionType
                let id: String
                let image: String?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: String
                let progressingProjects: [Project]
                let finishedProjects: [Project]
            }
            
            struct CurrentUser {
                let id: String
                let name: String
                let image: String
                let email: String
                let ocupation: String
            }
            
            struct Project {
                let id: String
                let image: Data
            }
        }
        
        struct ViewModel {
            
            struct User {
                let connectionTypeImage: UIImage?
                let image: String?
                let name: NSAttributedString
                let occupation: NSAttributedString
                let email: NSAttributedString
                let phoneNumber: NSAttributedString
                let connectionsCount: NSAttributedString
                let progressingProjects: [Project]
                let finishedProjects: [Project]
            }
            
            struct Project {
                let id: String
                let image: UIImage?
            }
        }
    }
    
    struct Request {
        
        struct FetchNotifications {
            let userId: String
        }
        
        struct NewConnectNotification {
            let fromUserId: String
            let toUserId: String
            let name: String
            let ocupation: String
            let email: String
            let image: String
            var oldNotifications: Array<ProfileDetails.Response.Notification>
        }
        
        struct FetchCurrentUserId {
            
        }
        
        struct FetchCurrentUserData {
            let userId: String
        }
        
        struct UserData {
            
        }
        
        struct AddConnection {
            
        }
        
        struct AllConnections {
            
        }
        
        struct ProjectInfo {
            let id: String
        }
    }
    
    struct Errors {
        
        struct ProfileDetailsError {
            let description: String
        }
    }
    
    struct Response {
        
        final class User: Mappable {
            
            var id: String?
            var name: String?
            var email: String?
            var ocupation: String?
            var phoneNumber: String?
            var image: String?
            
            init?(map: Map) {}
                       
            func mapping(map: Map) {
                id <- map["id"]
                name <- map["name"]
                email <- map["email"]
                ocupation <- map["professional_area"]
                phoneNumber <- map["phone_number"]
                image <- map["profile_image_url"]
            }
        }
        
        final class Notification: Mappable {
            
            var email: String?
            var image: String?
            var name: String?
            var ocupation: String?
            var userId: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                email <- map["email"]
                image <- map["image"]
                name <- map["name"]
                ocupation <- map["ocupation"]
                userId <- map["userId"]
            }
        }
        
        enum AllNotifications {
            case success(NotificationsResponseData)
            case error
        }
        
        enum CurrentUserId {
            case success(String)
            case error
        }
        
        enum CurrentUser {
            case success(CurrentUserResponseData)
            case error
        }
        
        enum AddConnection {
            case success
            case error(Error)
        }
        
        struct NotificationsResponseData {
            let notifications: Array<Any>
        }
        
        struct CurrentUserResponseData {
            let userData: [String : Any]
        }
    }
}
