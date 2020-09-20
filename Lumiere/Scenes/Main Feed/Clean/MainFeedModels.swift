//
//  MainFeedModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct MainFeed {
    
    static let bundle = Bundle(for: MainFeedController.self)
    
    struct Constants {
        
        struct Colors {
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
        }
        
        struct Fonts {
            static let searchTextField = ThemeFonts.RobotoRegular(14).rawValue
        }
        
        struct Texts {
            
        }
        
        struct Images {
            static let lumiere = UIImage(named: "tipografia-projeto 2",
                                         in: MainFeed.bundle,
                                         compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heighs {
                
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
        }
        
        struct Model {
            
        }
        
        struct ViewModel {
            
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
    }
}
