//
//  ProjectStepsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

struct ProjectSteps {
    
    struct Constants {
        
        struct Texts {
            static let titleLbl = "Como está o seu projeto?"
            static let zeroPercentLbl = "0%"
            static let hundredPercentLbl = "100%"
            static let advanceButton = "Avançar"
        }
        
        struct Fonts {
            static let titleLbl = UIFont(name: "Roboto-Bold", size: 16)
            static let zeroPercentLbl = UIFont(name: "Roboto-Bold", size: 16)
            static let hundredPercentLbl = UIFont(name: "Roboto-Bold", size: 16)
            static let advanceButton = UIFont(name: "Roboto-Bold", size: 16)
        }
        
        struct Colors {
            static let background = UIColor(rgb: 0xffffff)
            static let titleLbl = UIColor(rgb: 0x000000)
            static let zeroPercentLbl = UIColor(rgb: 0x000000)
            static let hundredPercentLbl = UIColor(rgb: 0x000000)
            static let advanceButton = UIColor(rgb: 0xc4c4c4)
            static let stepSliderBackground = UIColor(rgb: 0xffffff)
        }
        
        struct Images {
            static let stepSliderNormal = UIImage(named: "logo-apenas 2")?.alpha(0.7)
            static let stepSliderMinimum = UIImage(named: "logo-apenas 2")?.alpha(0.5)
            static let stepSliderMaximum = UIImage(named: "logo-apenas 2")?.alpha(1.0)
        }
    }
}
