//
//  Answer.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import Foundation

struct Answer: Identifiable {
    var id: String { word.hint }
    var word: Word
    var isSolved = false
    // What is the word we are trying to load
    init(word: Word) {
        self.word = word
    }
    var imageName: String {
        "\(word.solution.count).circle.fill"
    }
}
