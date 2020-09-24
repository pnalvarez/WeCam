//
//  Stubbable.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol Stubbable {
    static var stub: Self { get }
}

protocol MultipleStubbable {
    static var stubArray: [Self] { get }
}
