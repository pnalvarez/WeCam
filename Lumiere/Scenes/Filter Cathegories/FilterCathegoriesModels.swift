//
//  FilterCathegoriesModels.swift
//  WeCam
//
//  Created by Pedro Alvarez on 17/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

enum FilterCathegories {
    
    enum Constants {
        
        enum Colors {
            static let titleLbl = UIColor(rgb: 0x707070)
        }
        
        enum Fonts {
            static let titleLbl = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        enum Texts {
            static let titleLbl = "Categorias"
        }
        
        enum BusinessLogic {
            
        }
    }
    
    enum Info {
        
        enum Received {
            
        }
        
        enum Response {
            
            final class SelectedCathegories: Mappable {
                
                var cathegories: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    cathegories <- map["cathegories"]
                }
            }
        }
        
        enum Model {
            
        }
        
        enum ViewModel {
            
        }
    }
    
    enum Request {
        
        struct FetchSelectedCathegories {
            
        }

        struct SelectCathegory {
            let index: Int
        }
        
        struct Filter {
            
        }
        
        struct FilterCathegories {
            let cathegories: [String]
        }
    }
}
