//
//  Segment.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/18/23.
//

import Foundation

struct Segment {
    var text: String
    var isUsed = false
    init(text: String) {
        self.text = text
    }
    static let example = Segment(text: "ABC")
}
