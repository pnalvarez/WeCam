//
//  MovieStyle.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

enum MovieStyle: String, CaseIterable {
    case action = "Ação"
    case animation = "Animação"
    case adventure = "Aventura"
    case comedy = "Comédia"
    case drama = "Drama"
    case dance = "Dança"
    case documentary = "Documentário"
    case fiction = "Ficção Científica"
    case war = "Guerra"
    case musical = "Musical"
    case police = "Policial"
    case series = "Seriado"
    case suspense = "Suspense"
    case horror = "Terror"
    
    static func toArray() -> [MovieStyle] {
        var array: [MovieStyle] = []
        for value in MovieStyle.allCases {
            array.append(value)
        }
        return array
    }
}
