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
            static let acceptedProjectInvite = "Você agora faz parte deste projeto"
            static let refusedProjectInvite = "Você recusou o convite para este projeto"
            static let acceptedProjectParticipationRequest = "agora faz parte do seu projeto"
            static let refusedProjectParticipationRequest = "foi recusado no seu projeto"
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
            
            enum UserRelation {
                case connected
                case pending
                case sent
                case logged
                case nothing
            }
            
            struct AllNotifications {
                var notifications: [Notifications.Info.Model.NotificationType] 
            }
            
            struct UpcomingConnectNotifications {
                var notifications: [ConnectNotification]
            }
            
            struct UpcomingProjectInvites {
                var notifications: [ProjectInviteNotification]
            }
            
            struct UpcomingProjectParticipationRequests {
                var notifications: [ProjectParticipationRequestNotification]
            }
            
            class NotificationType {
                let userId: String
                let userName: String
                let image: String
                
                init(userId: String,
                     userName: String,
                     image: String) {
                    self.userId = userId
                    self.userName = userName
                    self.image = image
                }
            }
            
            class ConnectNotification: NotificationType {
                let ocupation: String
                let email: String
                
                init(userId: String,
                     userName: String,
                     image: String,
                     ocupation: String,
                     email: String) {
                    self.ocupation = ocupation
                    self.email = email
                    super.init(userId: userId, userName: userName, image: image)
                }
            }
            
            class ProjectInviteNotification: NotificationType {
                let projectId: String
                let projectName: String
                
                init(userId: String,
                              userName: String,
                              image: String,
                              projectId: String,
                              projectName: String) {
                    self.projectId = projectId
                    self.projectName = projectName
                    super.init(userId: userId, userName: userName, image: image)
                }
            }
            
            class ProjectParticipationRequestNotification: NotificationType {
                let projectId: String
                let projectName: String
                let email: String
                let ocupation: String
                
                init(userId: String,
                            userName: String,
                              image: String,
                              projectId: String,
                              projectName: String,
                              email: String,
                              ocupation: String) {
                    self.projectId = projectId
                    self.projectName = projectName
                    self.email = email
                    self.ocupation = ocupation
                    super.init(userId: userId, userName: userName, image: image)
                }
            }
            
            struct User {
                let userId: String
            }
            
            struct Project {
                let projectId: String
            }
        }
        
        struct ViewModel {
            
            /////

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
                var selectable: Bool
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
        
        struct RefuseParticipationRequest {
            let projectId: String
            let userId: String
        }
        
        struct FetchAcceptUserIntoProject {
            let userId: String
            let projectId: String
        }
        
        struct FetchProjectParticipationRequestNotifications {
            
        }
        
        struct AcceptProjectInvite {
            let projectId: String
        }
        
        struct RefuseProjectInvite {
            let projectId: String
        }
        
        struct FetchInvitingUser {
            let userId: String
        }
        
        struct FetchConnectionNotifications {
            let userId: String
        }
        
        struct ProjectInviteNotifications {
            
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
        
        final class ProjectInvite: Mappable {
            
            var projectId: String?
            var authorId: String?
            var projectTitle: String?
            var image: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                projectId <- map["projectId"]
                authorId <- map["author_id"]
                projectTitle <- map["project_title"]
                image <- map["image"]
            }
        }
        
        final class ProjectParticipationRequest: Mappable {
            
            var projectId: String?
            var userId: String?
            var userName: String?
            var userEmail: String?
            var ocupation: String?
            var image: String?
            var projectName: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                projectId <- map["projectId"]
                userId <- map["userId"]
                userName <- map["userName"]
                userEmail <- map["userEmail"]
                ocupation <- map["userOcupation"]
                image <- map["image"]
                projectName <- map["projectName"]
            }
        }
        
        final class InvitingUser: Mappable {
            
            var name: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                name <- map["name"]
            }
        }
    }
}