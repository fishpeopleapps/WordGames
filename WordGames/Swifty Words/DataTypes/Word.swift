//
//  Word.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import Foundation

struct Word: Hashable, Decodable {
    var id: String { hint }
    var solution: String
    var hint: String
    var segments: [String]
    static let example = Word(solution: "Example solution", hint: "Example hint", segments: ["ABC", "DEF"])
}
