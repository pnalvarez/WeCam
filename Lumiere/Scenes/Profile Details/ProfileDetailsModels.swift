//
//  ProfileDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

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
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct User {
                let id: String
                let image: Data?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: Int
                let progressingProjectsIds: [String]
                let finishedProjectsIds: [String]
            }
        }
        
        struct Model{
            
            struct User {
                let id: String
                let image: Data?
                let name: String
                let occupation: String
                let email: String
                let phoneNumber: String
                let connectionsCount: Int
                let progressingProjects: [Project]
                let finishedProjects: [Project]
            }
            
            struct Project {
                let id: String
                let image: Data
            }
        }
        
        struct ViewModel {
            
            struct User {
                let image: UIImage?
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
        
    }
    
    struct Response {
        
    }
}
