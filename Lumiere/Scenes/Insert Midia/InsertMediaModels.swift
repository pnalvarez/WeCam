//
//  InsertMediaModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct InsertMedia {
    
    struct Constants {
        
        struct Colors {
            static let insertUrlLbl = UIColor(rgb: 0x707070)
            static let inputTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let inputTextFieldText = UIColor(rgb: 0x55a3ff)
            static let inputTextFieldBackground = UIColor(rgb: 0x000000)
            static let previewLbl = UIColor(rgb: 0x707070)
            static let submitButtonBackgroundEnabled = ThemeColors.mainRedColor.rawValue
            static let submitButtonBackgroundDisabled = ThemeColors.mainRedColor.rawValue.withAlphaComponent(0.4)
            static let submitButtonText = ThemeColors.whiteThemeColor.rawValue
        }
        
        struct Fonts {
            static let insertUrlLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let inputTextField = ThemeFonts.RobotoRegular(14).rawValue
            static let previewLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let submitButton = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let insertUrlLbl = "Insira a URL"
            static let previewLbl = "Preview"
            static let submitButton = "Publicar"
            static let urlNotFound = "URL não encontrada"
        }
        
        struct Images {
            
        }
        
        struct BusinessLogic {
            
        }
    }
    
    struct Info {
        
        struct Response {
            
            final class Project: Mappable {
                var id: String?
                var title: String?
                var cathegories: [String]?
                var sinopsis: String?
                var teamMembers: [String]?
                var image: String?
                var authorId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["project_id"]
                    title <- map["title"]
                    cathegories <- map["cathegories"]
                    sinopsis <- map["sinopsis"]
                    teamMembers <- map["participants"]
                    image <- map["image"]
                    authorId <- map["author_id"]
                }
            }
        }
        
        struct Received {
            
            struct FinishingProject {
                let id: String
            }
        }
        
        struct Model {
            
            struct Media {
                let videoId: String
            }
            
            struct FinishedProject {
                let id: String
                let title: String
                let cathegories: [String]
                let sinopsis: String
                let teamMembers: [String]
                let image: String
                let media: String
                let finishDate: Date
            }
        }
        
        struct ViewModel {
            
            struct Media {
                let videoId: String
            }
        }
    }
    
    struct Request {
        
        struct FetchVideo {
            let url: String
        }
        
        struct Publish {
            
        }
        
        struct FetchProjectDetails {
            let id: String
        }
        
        struct SubmitVideo {
            let projectId: String
            let projectTitle: String
            let sinopsis: String
            let cathegories: [String]
            let participants: [String]
            let image: String
            let media: String
            let finishedDate: Int
        }
    }
}