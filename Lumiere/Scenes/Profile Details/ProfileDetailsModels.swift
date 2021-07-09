//
//  ProfileDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit
import ObjectMapper

struct ProfileDetails {
    
    static let bundle = Bundle(for: ProfileDetailsController.self)
    
    struct Constants {
        
        struct Colors {
            static let allConnectionsButton = UIColor(rgb: 0xe50c3c)
            static let nameLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let phoneNumberLbl = UIColor(rgb: 0x000000)
            static let allConnectionsButtonText = UIColor(rgb: 0xffffff)
            static let activity = ThemeColors.mainRedColor.rawValue
            static let activityBackground = UIColor(rgb: 0xffffff)
            static let translucentView = UIColor(rgb: 0xededed).withAlphaComponent(0.8)
            static let editProfileButtonLayer = UIColor(rgb: 0x969494).cgColor
            static let editProfileButtonBackgrounnd = UIColor(rgb: 0xffffff)
            static let editProfileButtonText = UIColor(rgb: 0x969494)
            static let onGoingProjectsLbl = UIColor(rgb: 0x969494)
            static let inviteToProjectButtonBackground = UIColor(rgb: 0xededed)
            static let inviteToProjectButtonText = UIColor(rgb: 0x000000)
            static let finishedProjectsLbl = UIColor(rgb: 0x969494)
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let phoneNumberLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let allConnectionsButton = ThemeFonts.RobotoBold(16).rawValue
            static let editProfileButton = ThemeFonts.RobotoBold(16).rawValue
            static let onGoingProjectsLbl = ThemeFonts.RobotoBold(16).rawValue
            static let inviteToProjectButton = ThemeFonts.RobotoRegular(16).rawValue
            static let finishedProjectsLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Images {
            static let backButton = UIImage(named: "voltar 1")
            static let addConnection = UIImage(named: "fazer-conexao 1")
            static let isConnection = UIImage(named: "icone-conexao-feita 1")
            static let pending = UIImage(named: "pendente 1")
            static let sent = UIImage(named: "icone-pendente 1")
            static let logout = UIImage(named: "ajustar 1", in: ProfileDetails.bundle, compatibleWith: nil)
            static let tabBarDefaultImage = UIImage(named: "perfil-antes-de-clicar 1",
                                                    in: ProfileDetails.bundle,
                                                    compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
            static let tabBarSelectedImage = UIImage(named: "perfil-depois-de-clicar 1",
                                                     in: ProfileDetails.bundle,
                                                     compatibleWith: nil)
        }
        
        struct Texts {
            static let addConnectionError = "Erro ao tentar adicionar conexão"
            static let genericError = "Ocorreu um erro genérico"
            static let editProfileButton = "Editar Perfil"
            static let onGoingProjectsLbl = "Projetos em andamento"
            static let inviteToProjectButton = "Convidar para projeto"
            static let finishedProjectsLbl = "Projetos Finalizados"
            static let emptyOngoingProjectsList = "Nenhum projeto em andamento no momento"
            static let emptyFinishedProjectsList = "Nenhum projeto já finalizado no portfolio"
        }
        
        struct Dimensions {
            
            static let projectViewDefaultOffset: CGFloat = 50
            static let finishedProjectButtonDefaultOffset: CGFloat = 50
            static let lineSpacingSection: CGFloat = 10
            static let interItemSpacing: CGFloat = 10
            static let horizontalMargin: CGFloat = 26
            static let verticalMargin: CGFloat = 0
            
            struct Heights {
                static let scrollView: CGFloat = 84
                static let finishedScrollView: CGFloat = 254
                static let ongoingProjects: CGFloat = 84
                static let finishedProjects: CGFloat = 128
            }
            
            struct Widths {
                static let projectView: CGFloat = 84
                static let finishedProjectButton: CGFloat = 159
                static let spaceBetweenProjects = 28
                static let spaceBetweenFinishedProjects = 12
                static let ongoingProjects: CGFloat = 84
                static let finishedProjects: CGFloat = 128
            }
        }
    }
    
    struct Info {
        
        enum ConnectionType {
            case contact
            case sent
            case pending
            case nothing
            case logged
        }
        
        struct Received {
            
            struct User {
                let userId: String
            }
        }
        
        struct Model{
            
            enum UserType {
                case logged
                case other
            }
            
            struct IneractionConfirmation: Equatable {
                let connectionType: ConnectionType
            }
            
            struct User: Equatable {
                
                var connectionType: ConnectionType?
                let id: String
                let image: String?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: Int
                var progressingProjects: [Project]
                var finishedProjects: [Project]
            }
            
            struct CurrentUser {
                let id: String
                let name: String
                let image: String
                let email: String
                let ocupation: String
            }
            
            struct Project: Equatable {
                let id: String
                let image: String
            }
            
            struct NewConnectionType: Equatable {
                let connectionType: ConnectionType
            }
        }
        
        struct ViewModel {
            
            struct User: Equatable {
                let connectionType: WCProfileHeaderView.RelationState
                let image: String?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: Int
                let progressingProjects: [Project]
                let finishedProjects: [Project]
            }
            
            struct Project: Equatable {
                let image: String
            }
            
            struct NewConnectionType: Equatable {
                let type: WCProfileHeaderView.RelationState
            }
            
            struct InteractionConfirmation: Equatable {
                let text: String
            }
        }
    }
    
    struct Request {
        
        struct SelectProjectWithIndex {
            let index: Int
        }
        
        struct SelectProjectWithId {
            let projectId: String
        }
        
        struct FetchUserRelation {
            let userId: String
        }
        
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
        
        struct FetchUserData {
            
        }
        
        struct FetchUserDataWithId {
            let userId: String
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
        
        struct FetchUserProjects {
            let userId: String
        }
        
        struct ProjectInfo {
            let id: String
        }
        
        struct RemoveConnection {
            let id: String
        }
        
        struct RemovePendingConnection {
            let id: String
        }
        
        struct SendConnectionRequest {
            let id: String
        }
        
        struct AcceptConnectionRequest {
            let id: String
        }
        
        struct SignOut {
            
        }
        
        struct ConfirmInteraction {
            
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
            var connectionsCount: Int?
            
            init?(map: Map) {}
                       
            func mapping(map: Map) {
                id <- map["userId"]
                name <- map["name"]
                email <- map["email"]
                ocupation <- map["professional_area"]
                phoneNumber <- map["phone_number"]
                image <- map["profile_image_url"]
                connectionsCount <- map["connections_count"]
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
        
        final class Project: Mappable {
            
            var projectId: String?
            var image: String?
            var title: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                projectId <- map["projectId"]
                image <- map["image"]
                title <- map["title"]
            }
        }
        
        final class UserRelation: Mappable {
            
            var relation: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                relation <- map["relation"]
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
            case error(WCError)
        }
        
        struct NotificationsResponseData {
            let notifications: Array<Any>
        }
        
        struct CurrentUserResponseData {
            let userData: [String : Any]
        }
    }
}

extension ProfileDetails.Response.Project: Stubbable {
    static var stub: ProfileDetails.Response.Project {
        return ProfileDetails
            .Response
            .Project(JSONString:
                                                """
                    {
                        "projectId": "idProj",
                        "image": "image_url",
                        "title": "Projeto Teste"
                    }
                    """)!
    }
}

extension ProfileDetails.Response.User: Stubbable {
    static var stub: ProfileDetails.Response.User {
        return ProfileDetails
            .Response
            .User(JSONString:
                                                """
                    {
                        "userId": "idUser",
                        "name": "Usuario Teste",
                        "email": "user_test1@hotmail.com",
                        "professional_area": "Artist",
                        "phone_number": "(20)9820-1189",
                        "profile_image_url": "image_url"
                    }
                    """)!
    }
}

extension ProfileDetails.Response.UserRelation: Stubbable {
    static var stub: ProfileDetails.Response.UserRelation {
        return ProfileDetails
            .Response
            .UserRelation(JSONString:
                                                """
                    {
                        "relation": "CONNECTED"
                    }
                    """)!
    }
}

extension ProfileDetails.Response.Project: MultipleStubbable {
    static var stubArray: [ProfileDetails.Response.Project] {
        return [
            ProfileDetails
                .Response
                .Project(JSONString:
                                                    """
                        {
                            "projectId": "idProj1",
                            "image": "image_url1",
                            "title": "Projeto Teste 1"
                        }
                        """)!,
            ProfileDetails
                .Response
                .Project(JSONString:
                                                    """
                        {
                            "projectId": "idProj2",
                            "image": "image_url2",
                            "title": "Projeto Teste 2"
                        }
                        """)!,
            ProfileDetails
                .Response
                .Project(JSONString:
                                                    """
                        {
                            "projectId": "idProj3",
                            "image": "image_url3",
                            "title": "Projeto Teste 3"
                        }
                        """)!
                ]
    }
}

extension ProfileDetails.Info.Model.User: Stubbable {
    static var stub: ProfileDetails.Info.Model.User {
        return ProfileDetails.Info.Model.User(connectionType: .contact,
                                              id: "idUser",
                                              image: "image",
                                              name: "Usuario Teste",
                                              occupation: "Artista",
                                              email: "user_test@hotmail.com",
                                              phoneNumber: "(20)3938-3948",
                                              connectionsCount: 10,
                                              progressingProjects: ProfileDetails.Info.Model.Project.stubArray, finishedProjects: .empty)
    }
}

extension ProfileDetails.Info.Model.Project: MultipleStubbable {
    static var stubArray: [ProfileDetails.Info.Model.Project] {
        return [ProfileDetails.Info.Model.Project(id: "idProj1",
                                                  image: "image1"),
                ProfileDetails.Info.Model.Project(id: "idProj2",
                                                  image: "image2")]
    }
}

extension ProfileDetails.Info.ViewModel.Project: MultipleStubbable {
    static var stubArray: [ProfileDetails.Info.ViewModel.Project] {
        return [ProfileDetails.Info.ViewModel.Project(image: "image1"), ProfileDetails.Info.ViewModel.Project(image: "image2")]
    }
}
