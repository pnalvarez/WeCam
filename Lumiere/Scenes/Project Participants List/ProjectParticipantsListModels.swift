//
//  ProjectParticipantsListModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

struct ProjectParticipantsList {
    
    struct Constants {
        
        struct Colors {
            static let participantsFixedLbl = UIColor(rgb: 0x707070)
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let participantsFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let participantsFixedLbl = "Equipe"
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let projectId: String
            }
        }
        
        struct Model {
            
            struct UpcomingParticipants {
                let participants: [Participant]
            }
            
            struct Participant {
                let id: String
                let name: String
                let ocupation: String
                let image: String
                let email: String
            }
        }
        
        struct ViewModel {
            
            struct UpcomingParticipants {
                let participants: [Participant]
            }
            
            struct Participant {
                let name: String
                let ocupation: String
                let email: NSAttributedString
                let image: String
            }
        }
        
        struct Response {
            
            final class Participant: Mappable {
                
                var id: String?
                var name: String?
                var image: String?
                var ocupation: String?
                var email: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    name <- map["name"]
                    image <- map["profile_image_url"]
                    ocupation <- map["professional_area"]
                    email <- map["email"]
                }
            }
        }
    }
    
    struct Request {
        
        struct FetchParticipants {
            
        }
        
        struct FetchParticipantsWithId {
            let projectId: String
        }
        
        struct SelectParticipant {
            let index: Int
        }
    }
}
