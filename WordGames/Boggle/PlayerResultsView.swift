//
//  PlayerResultsView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/28/23.
//

import SwiftUI

struct PlayerResultsView: View {
    var playerNum: Int
    var score: Int
    var words: [String]
    var body: some View {
        Section {
            if words.isEmpty {
                Text("You didn't find any words :( ")
            } else {
                ForEach(words, id: \.self) { word in
                    Text("\(word) (\(word.score))")
                }
            }
        } header: {
            Text("Player \(playerNum) score")
        } footer: {
            Text("Total: ^[\(score) points](inflect: true)")
        }
    }
}
