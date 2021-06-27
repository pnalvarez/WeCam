//
//  MovieStyle.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

enum WCMovieStyle: String, CaseIterable {
    case action = "Ação"
    case animation = "Animação"
    case adventure = "Aventura"
    case comedy = "Comédia"
    case drama = "Drama"
    case dance = "Dança"
    case documentary = "Documentário"
    case fiction = "Ficção\n Científica"
    case war = "Guerra"
    case musical = "Musical"
    case romance = "Romance"
    case police = "Policial"
    case series = "Seriado"
    case suspense = "Suspense"
    case horror = "Terror"
    
    static func toArray() -> [WCMovieStyle] {
        var array: [WCMovieStyle] = []
        for value in WCMovieStyle.allCases {
            array.append(value)
        }
        array.sort(by: { return $0.rawValue < $1.rawValue })
        return array
    }
}
