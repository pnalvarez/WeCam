//
//  URL+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

extension URL {
    
    func getData(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: self, completionHandler: completion).resume()
    }
}
