//
//  UIImage+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func getImage(from data: Data?) -> UIImage? {
        guard let data = data else {
            return nil
        }
        return UIImage(data: data)
    }
}
