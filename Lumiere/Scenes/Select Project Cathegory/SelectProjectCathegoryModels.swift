//
//  SelectProjectCathegoryModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

struct SelectProjectCathegory {
    
    static let bundle = Bundle(for: SelectProjectCathegoryController.self)
    
    struct Constants {
        
        struct Colors {
            static let advanceButton = UIColor(rgb: 0xc4c4c4)
            static let titleLbl = UIColor(rgb: 0x707070)
        }
        
        struct Fonts {
            static let advanceButton = ThemeFonts.RobotoBold(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let advanceButton = "Avançar"
            static let titleLbl = "Categoria"
            static let defaultErrorTitle = "Atenção"
            static let failureToSelectMessage = "Selecione apenas duas categorias para o seu projeto"
            static let noCathegorySelectedErrorMessage = "Selecione no mínimo uma categoria para o seu projeto"
        }
        
        struct Images {
            static let backButton = UIImage(named: "voltar 1",
                                            in: SelectProjectCathegory.bundle,
                                            with: nil)
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let image: Data?
            }
        }
        
        struct Model {
            
            struct SelectedCathegories {
                var firstCathegory: MovieStyle?
                var secondCathegory: MovieStyle?
            }
            
            struct InterestCathegories: Equatable {
                var cathegories: [Cathegory]
            }
            
            struct Cathegory: Equatable {
                let cathegory: MovieStyle
                var selected: Bool
            }
        }
        
        struct ViewModel {
            
        }
        
        struct Response {
            
        }
        
        struct Errors {
            
            struct SelectionError {
                let title: String
                let message: String
            }
        }
    }
    
    struct Request {
        
        struct AllCathegories {
            
        }
        
        struct SelectCathegory {
            let cathegory: MovieStyle
        }
        
        struct Advance {
            
        }
    }
}
