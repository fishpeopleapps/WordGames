//
//  Dictionary.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/27/23.
//
// TODO: Add American Slang to dictionary 

import Foundation

/// This is an enum so we can't make another instance of it
/// It's also super fast, because the file is loaded once, and then we can access
/// the contains function instantly and repeatedly
enum Dictionary {
    private static let contents: Set<String> = {
        /// Look for the dictionary.txt file in our app bundle
        guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else {
            fatalError("Cannot find dictionary.txt")
        }
        guard let contents = try? String(contentsOf: url) else {
            fatalError("Couldn't load the dictionary.txt file")
        }
        return Set(contents.components(separatedBy: .newlines))
    }()
    /// Added so we can see if a specific word is in the set
    static func contains(_ word: String) -> Bool {
        contents.contains(word)
    }
}
