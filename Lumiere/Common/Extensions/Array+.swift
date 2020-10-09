//
//  Array+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

extension Array {
    
    static var empty: Array {
        return []
    }
    
    func outOfRange(withIndex index: Int) -> Bool {
        return index >= count
    }
    
    static func intersectionCount<T: Equatable>(between array1: [T], and array2: [T]) -> Int {
        return array1.filter({ elem in
            return array2.contains(where: { elem2 in
                return elem == elem2
            })
        }).count
    }
}
