//
//  ResultsView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/28/23.
//

import SwiftUI
/// This is where we'll show who won, comparing who got the word first and
/// how many points they gained for that word
struct ResultsView: View {
    var player1Words = [String]()
    var player2Words = [String]()
    var player1Score = 0
    var player2Score = 0
    var result: String
    var body: some View {
        NavigationStack {
            List {
                PlayerResultsView(playerNum: 1, score: player1Score, words: player1Words)
                PlayerResultsView(playerNum: 2, score: player2Score, words: player2Words)
            }
            .navigationTitle(result)
        }
    }
    /// This is to compute the properties above
    init(game: GameBrain) {
        // calculate player words and scores
        for (word, player) in game.scores {
            if player === game.player01 {
                player1Score += word.score
                player1Words.append(word)
            } else {
                player2Score += word.score
                player2Words.append(word)
            }
        }
        // sort the results words
        player1Words.sort()
        player2Words.sort()
        // calculate who won
        if player1Score > player2Score {
            result = "Player 1 Wins!"
        } else if player1Score < player2Score {
            result = "Player 2 Wins!"
        } else {
            result = "It's a draw!"
        }
    }
}
