//
//  NotificationsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import ObjectMapper

struct Notifications {
    
    static let bundle = Bundle(for: NotificationsController.self)
    
    struct Constants {
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let notificationLbl = ThemeFonts.RobotoBold(16).rawValue
            static let yesButtonLbl = ThemeFonts.RobotoBold(16).rawValue
            static let noButtonLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
            static let notificationLbl = UIColor(rgb: 0x000000)
            static let yesButtonText = UIColor(rgb: 0x000000)
            static let noButtonText = UIColor(rgb: 0x000000)
            static let background = UIColor(rgb: 0xffffff)
            static let yesButtonLayer = UIColor(rgb: 0xe5dfdf).cgColor
            static let noButtonLayer = UIColor(rgb: 0xe5dfdf).cgColor
            static let yesButtonBackground = UIColor(rgb: 0xededed)
            static let noButtonBackground = UIColor(rgb: 0xededed)
            static let yesButtonBackgroundClicked = UIColor(rgb: 0xc4c4c4)
            static let noButtonBackgroundClicked = UIColor(rgb: 0xc4c4c4)
            static let activity = ThemeColors.mainRedColor.rawValue
            static let activityBackground = UIColor.white.withAlphaComponent(0.5)
            static let notificationCellBackground = UIColor(rgb: 0xffffff)
            static let notificationCellLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let notificationCellAnsweredBackground = UIColor(rgb: 0xededed)
        }
        
        struct Texts {
            static let connectNotificationText = "Deseja permitir conexão?"
            static let projectParticipateText = "Quer participar do seu projeto?"
            static let projectPropertyText = "Você também é proprietário deste projeto?"
            static let noButton = "Não"
            static let yesButton = "Sim"
            static let error = "Ocorreu um erro ao tentar apresentar as notificações"
            static let acceptedConnection = "Você agora está conectado a"
            static let refusedConnection = "Você recusou se conectar a"
            static let emptyNotifications = "Você não possui notificações"
        }
        
        struct Dimensions {
            
            struct Heights {
                static let notificationTableViewCell: CGFloat = 194
            }
        }
        
        struct Images {
            static let tabBarDefaultImage = UIImage(named: "notificacao-antes-de-clicar 1-1",
                                                    in: Notifications.bundle,
                                                    compatibleWith: nil)
            static let tabBarSelectedImage = UIImage(named: "notificacao-depois-de-clicar 1-1",
                                                     in: Notifications.bundle,
                                                     compatibleWith: nil)
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct CurrentUser {
                let userId: String
            }
        }
        
        struct Model {
            
            enum NotificationAnswer {
                case accepted
                case refused
            }
            
            enum NotificationType {
                case connection
                case projectParticipation
                case projectAuthorizing
            }
            
            enum UserRelation {
                case connected
                case pending
                case sent
                case logged
                case nothing
            }
            
            struct UpcomingNotifications {
                var notifications: [Notification]
            }
            
            struct Notification {
                let type: NotificationType
                let userId: String
                let image: String?
                let name: String
                let ocupation: String
                let email: String
            }
            
            struct User {
                let userId: String
            }
        }
        
        struct ViewModel {
            
            struct NotificationAnswer {
                let index: Int
                let text: String
            }
            
            struct UpcomingNotifications {
                var notifications: [Notification]
            }
            
            struct Notification {
                let notificationText: String
                let image: String?
                let name: String
                let ocupation: String
                let email: NSAttributedString
            }
            
            struct NotificationError {
                let description: String
            }
        }
    }
    
    struct Errors {
        
        enum GenericError: Error {
            case generic
        }

        struct NotificationError {
            let error: Error
        }
    }
    
    struct Request {
        
        struct FetchNotifications {
            let userId: String
        }
        
        struct UpdateNotifications {
            let userId: String
        }
        
        struct SelectProfile {
            let index: Int
        }
        
        struct NotificationAnswer {
            let index: Int
        }
        
        struct FetchImageData {
            let url: URL
        }
        
        struct FetchUserData {
            let userId: String
        }
        
        struct ConnectUsers {
            let fromUserId: String
            let toUserId: String
        }
        
        struct UserRelation {
            let fromUserId: String
            let toUserId: String
        }
        
        struct RemovePendingNotification {
            let userId: String
        }
        
        struct RefreshNotifications {
            
        }
    }
    
    struct Response {
        
        final class User: Mappable {
            
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
        
        final class ConnectNotification: Mappable {
            
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
        
        final class Relation: Mappable {
            
            var relation: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                relation <- map["relation"]
            }
        }
    }
}
