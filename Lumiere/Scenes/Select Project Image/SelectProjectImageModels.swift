//
//  SelectProjectImageModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

struct SelectProjectImage {
    
    static let bundle = Bundle(for: SelectProjectImageController.self)
    
    struct Constants {
        
        struct Colors {
            static let advanceButton = UIColor(rgb: 0xc4c4c4)
            static let selectedImageViewLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let titleLbl = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let advanceButton = ThemeFonts.RobotoBold(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let advanceButton = "Avançar"
            static let titleLbl = "Escolha a imagem do seu projeto".uppercased()
        }
        
        struct Images {
            static let backButton = UIImage(named: "voltar 1", in: SelectProjectImage.bundle, compatibleWith: nil)
        }
    }
    
    struct Info {
        
        struct Received {
            
        }
        
        struct Model {
            
        }
        
        struct ViewModel {
            
            struct AlbumImages {
                let images: [Image]
            }
            
            struct Image {
                let image: UIImage
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
    }
}
