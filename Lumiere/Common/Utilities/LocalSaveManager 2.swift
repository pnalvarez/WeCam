//
//  LocalSaveManager.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 06/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

class LocalSaveManager {
    
    private let userDefaults = UserDefaults.standard
    
    private let recentSearchesPath = "recentSearches"
    
    static let instance = LocalSaveManager()
    
    private init() { }
    
    func saveRecentSearches(_ searches: [String] = .empty) {
        userDefaults.set(searches, forKey: recentSearchesPath)
    }
    
    func saveRecentSearch(_ search: String) {
        guard var searches = userDefaults.value(forKey: recentSearchesPath) as? [String] else {
            return
        }
        searches.append(search)
        saveRecentSearches(searches)
    }
    
    func removeRecentSearch(_ id: String) {
        guard var searches = userDefaults.value(forKey: recentSearchesPath) as? [String] else {
            return
        }
        searches.removeAll(where: { $0 == id })
    }
    
    func fetchRecentSearches() -> [String] {
        guard let searches = userDefaults.value(forKey: recentSearchesPath) as? [String] else {
            return .empty
        }
        return searches
    }
}
