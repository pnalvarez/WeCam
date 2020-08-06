//
//  NotificationsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

struct Notifications {
    
    struct Constants {
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let phoneNumberLbl = ThemeFonts.RobotoRegular(15).rawValue
            static let notificationLbl = ThemeFonts.RobotoBold(16).rawValue
            static let yesButtonLbl = ThemeFonts.RobotoBold(16).rawValue
            static let noButtonLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
            static let phoneNumberLbl = UIColor(rgb: 0x000000)
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
            static let activity = UIColor(rgb: 0x222222)
            static let activityBackground = UIColor(rgb: 0xffffff)
            static let notificationCellBackground = UIColor(rgb: 0xffffff)
            static let notificationCellLayer = UIColor(rgb: 0xe0e0e0).cgColor
        }
        
        struct Texts {
            static let connectNotificationText = "Deseja permitir conexão?"
            static let projectParticipateText = "Quer participar do seu projeto?"
            static let projectPropertyText = "Você também é proprietário deste projeto?"
            static let noButton = "Não"
            static let yesButton = "Sim"
            static let error = "Ocorreu um erro ao tentar apresentar as notificações"
        }
        
        struct Dimensions {
            
            struct Heights {
                static let notificationTableViewCell: CGFloat = 194
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct CurrentUser {
                let userId: String
            }
        }
        
        struct Model {
            
            enum NotificationType {
                case connection
                case projectParticipation
                case projectAuthorizing
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
                let id: String
                let name: String
                let email: String
                let phoneNumber: String
                let image: String?
                let ocupation: String
                let connectionsCount: String
                //TO DO PROJECTS
            }
        }
        
        struct ViewModel {
            
            struct UpcomingNotifications {
                var notifications: [Notification]
            }
            
            struct Notification {
                let notificationText: String
                let image: String?
                let name: String
                let ocupation: String
                let email: NSAttributedString
                let phoneNumber: String
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
    }
    
    struct Response {
        
        enum FetchNotifications {
            case success(FetchNotificationsResponseData)
            case error
        }
        
        enum FetchUser {
            case success(FetchUserResponseData)
            case error
        }
        
        struct FetchNotificationsResponseData {
            let notifications: Array<Any>
        }
        
        struct FetchUserResponseData {
            let data: [String : Any]
        }
    }
}
