//
//  Category.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import Foundation

struct Category: Hashable, Identifiable, Decodable {
    var id: String { name }
    var name: String
    var description: String
    var levels: [[Word]]
    static let example = Category(name: "Example Name", description: "Example Description", levels: [[.example]])
}
