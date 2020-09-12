//
//  ProjectProgressModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

struct ProjectProgress {
    
    static let bundle = Bundle(for: ProjectProgressController.self)
    
    struct Constants {
        
        struct Colors {
            static let mainLbl = UIColor(rgb: 0x000000)
            static let zeroPercentLbl = UIColor(rgb: 0x000000)
            static let hundredPercentLbl = UIColor(rgb: 0x000000)
            static let advanceButton = UIColor(rgb: 0xc4c4c4)
            static let progressSliderBackground = UIColor(rgb: 0xe0e0e0)
        }
        
        struct Fonts {
            static let mainLbl = ThemeFonts.RobotoBold(16).rawValue
            static let zeroPercentLbl = ThemeFonts.RobotoBold(16).rawValue
            static let hundredPercentLbl = ThemeFonts.RobotoBold(16).rawValue
            static let advanceButton = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let mainLbl = "Como está o progresso do seu projeto?"
            static let zeroPercentLbl = "0%"
            static let hundredPercentLbl = "100%"
            static let advanceButton = "Avançar"
        }
        
        struct Images {
            static let logo = UIImage(named: "logo-apenas",
                                      in: ProjectProgress.bundle,
                                      compatibleWith: nil)
            static let back = UIImage(named: "voltar 1",
                                      in: ProjectProgress.bundle,
                                      compatibleWith: nil)
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let image: Data?
                let cathegories: [String]
            }
        }
        
        struct Model {
            
            struct Project {
                let image: Data?
                let cathegories: [String]
                let progress: Float
            }
        }
        
        struct ViewModel {
            
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
       
        struct Advance {
            let percentage: Float
        }
    }
}
