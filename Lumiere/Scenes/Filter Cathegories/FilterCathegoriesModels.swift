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
            static let filterButton = "Filtrar"
        }
        
        enum BusinessLogic {
            
        }
    }
    
    enum Info {
        
        enum Received {
            
        }
        
        enum Response {
            
            final class CathegoryList: Mappable {
                
                var cathegories: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    cathegories <- map["cathegories"]
                }
            }
        }
        
        enum Model {
            
            struct CathegoryList {
                var cathegories: [MovieStyle]
            }
            
            struct Alert {
                let title: String
                let description: String
            }
        }
        
        enum ViewModel {
            
            struct SelectedCathegoryList {
                var indexes: [Int]
            }
            
            struct InterestCathegoryList {
                var cathegories: [String]
            }
            
            struct Alert {
                let title: String
                let description: String
            }
        }
    }
    
    enum Request {
        
        struct FetchInterestCathegories {
            
        }
        
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
