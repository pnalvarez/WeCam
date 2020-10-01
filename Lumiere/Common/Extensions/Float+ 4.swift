//
//  Float+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

extension Float {
    func truncate(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
