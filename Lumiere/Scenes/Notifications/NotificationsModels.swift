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
            static let onGoingProjectParticipateText = "Quer participar do seu projeto?"
            static let onGoingProjectPropertyText = "Você também é proprietário deste projeto?"
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
            static let acceptedFinishedProjectInvite = "Você confirmou sua participação neste projeto"
            static let refusedFinishedProjectInvite = "Você recusou ter participado deste projeto"
        }
        
        struct Dimensions {
            
            struct Heights {
                static let notificationTableViewCell: CGFloat = 194
            }
        }
        
        struct Images {
            static let tabBarDefaultImage = UIImage(named: "notificacao-antes-de-clicar 1-1",
                                                    in: Notifications.bundle,
                                                    compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
            static let tabBarSelectedImage = UIImage(named: "notificacao-depois-de-clicar 1",
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
            
            struct AllNotifications: Equatable {
                var defaultNotifications: [Notifications.Info.Model.NotificationType]
                var acceptNotifications: [Notifications.Info.Model.AcceptNotification]
            }
            
            struct UpcomingConnectNotifications {
                var notifications: [ConnectNotification]
            }
            
            struct UpcomingProjectInvites {
                var notifications: [OnGoingProjectInviteNotification]
            }
            
            struct UpcomingProjectParticipationRequests {
                var notifications: [OnGoingProjectParticipationRequestNotification]
            }
            
            struct UpcomingFinishedProjectInviteNotifications {
                var notifications: [FinishedProjectInviteNotification]
            }
            
            class NotificationType: Equatable {
                
                static func == (lhs: Notifications.Info.Model.NotificationType, rhs: Notifications.Info.Model.NotificationType) -> Bool {
                    return lhs.userId == rhs.userId && lhs.userName == rhs.userName && lhs.image == rhs.image
                }
                
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
            
            class OnGoingProjectInviteNotification: NotificationType {
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
            
            class OnGoingProjectParticipationRequestNotification: NotificationType {
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
            
            class FinishedProjectInviteNotification: NotificationType {
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
            
            struct User {
                let userId: String
            }
            
            struct Project {
                let projectId: String
            }
            
            struct AcceptNotification: Equatable {
                let image: String
                let text: String
            }
        }
        
        struct ViewModel {
            
            /////

            struct NotificationAnswer: Equatable {
                let index: Int
                let text: String
            }
            
            struct UpcomingNotifications: Equatable {
                var notifications: [Notification]
            }
            
            struct Notification: Equatable {
                let notificationText: String
                let image: String?
                let name: String
                let ocupation: String
                let email: NSAttributedString
                var selectable: Bool
            }
            
            struct NotificationError: Equatable {
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
        
        struct AcceptFinishedProjectInvite {
            let projectId: String
        }
        
        struct RefuseFinishedProjectInvite {
            let projectId: String
        }
        
        struct AcceptNotifications {
            
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
        
        final class OnGoingProjectInvite: Mappable {
            
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
        
        final class OnGoingProjectParticipationRequest: Mappable {
            
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
        
        final class FinishedProjectInviteNotification: Mappable {
            var projectId: String?
            var authorId: String?
            var authorName: String?
            var projectTitle: String?
            var projectImage: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                projectId <- map["projectId"]
                authorId <- map["authorId"]
                projectTitle <- map["projectTitle"]
                projectImage <- map["image"]
                authorName <- map["authorName"]
            }
        }
        
        final class InvitingUser: Mappable {
            
            var name: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                name <- map["name"]
            }
        }
        
        final class AcceptNotification: Mappable {
            var image: String?
            var text: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                image <- map["image"]
                text <- map["text"]
            }
        }
    }
}

extension Notifications.Response.ConnectNotification: MultipleStubbable {
    static var stubArray: [Notifications.Response.ConnectNotification] {
        return [Notifications
            .Response
            .ConnectNotification(JSONString: """
                        {
                            "email": "user_test1@hotmail.com",
                            "image": "image",
                            "name": "Usuario Teste 1",
                            "ocupation": "Artista",
                            "userId": "idUser1"
                        }
            """
            )!,
                Notifications
                    .Response
                    .ConnectNotification(JSONString: """
                                {
                                    "email": "user_test2@hotmail.com",
                                    "image": "image",
                                    "name": "Usuario Teste 2",
                                    "ocupation": "Artista",
                                    "userId": "idUser2"
                                }
                    """
                    )!
        ]
    }
}

extension Notifications.Response.OnGoingProjectInvite: MultipleStubbable {
    static var stubArray: [Notifications.Response.OnGoingProjectInvite] {
        return [
            Notifications.Response.OnGoingProjectInvite(JSONString: """
                        {
                            "projectId": "idProj1",
                            "author_id": "idUser1",
                            "project_title": "Projeto Teste 1",
                            "image": "image"
                        }
                """)!,
            Notifications.Response.OnGoingProjectInvite(JSONString: """
                        {
                            "projectId": "idProj2",
                            "author_id": "idUser2",
                            "project_title": "Projeto Teste 2",
                            "image": "image"
                        }
                """)!
        ]
    }
}

extension Notifications.Response.User: Stubbable {
    static var stub: Notifications.Response.User {
        return Notifications.Response.User(JSONString: """
                    {
                        "name": "Usuario Teste",
                        "email": "user_test@hotmail.com",
                        "professional_area": "Artista",
                        "phone_number": "(20)9999-9999",
                        "profile_image_url": "image",
                        "connections_count": "0"
                    }
            """)!
    }
}

extension Notifications.Response.InvitingUser: Stubbable {
    static var stub: Notifications.Response.InvitingUser {
        return Notifications.Response.InvitingUser(JSONString: """
                            {
                                "name": "Usuario Teste"
                            }
                """)!
    }
}

extension Notifications.Response.OnGoingProjectParticipationRequest: MultipleStubbable {
    
    static var stubArray: [Notifications.Response.OnGoingProjectParticipationRequest] {
        return [Notifications.Response.OnGoingProjectParticipationRequest(JSONString: """
                        {
                            "projectId": "idProj1",
                            "userId": "idUser1",
                            "userName": "Usuario Teste 1",
                            "userEmail": "user_test1@hotmail.com",
                            "userOcupation": "Artista",
                            "image": "image",
                            "projectName": "Projeto Teste 1"
                        }
                """)!,
                Notifications.Response.OnGoingProjectParticipationRequest(JSONString: """
                                {
                                    "projectId": "idProj2",
                                    "userId": "idUser2",
                                    "userName": "Usuario Teste 2",
                                    "userEmail": "user_test2@hotmail.com",
                                    "userOcupation": "Artista",
                                    "image": "image",
                                    "projectName": "Projeto Teste 2"
                                }
                        """)!
        ]
    }
}

extension Notifications.Info.Model.AllNotifications: Stubbable {
    static var stub: Notifications.Info.Model.AllNotifications {
        return Notifications.Info.Model.AllNotifications(defaultNotifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.OnGoingProjectInviteNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.OnGoingProjectParticipationRequestNotification(userId: "idUser3", userName: "Usuario Teste 3", image: "image", projectId: "idProj3", projectName: "Projeto Teste 3", email: "user_test3@hotmail.com", ocupation: "Artista")], acceptNotifications: .empty)
    }
}

