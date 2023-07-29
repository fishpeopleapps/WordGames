//
//  GameBrain.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//
import Combine
import Foundation

class GameBrain: ObservableObject {
    /// Key - the word that was scored, Player - who scored it first
    var scores = [String: Player]()
    /// Array that holds a dice, which is an array of letter(s)
    var dice = [
            ["A", "A", "E", "E", "G", "N"],
            ["A", "B", "B", "J", "O", "O"],
            ["A", "C", "H", "O", "P", "S"],
            ["A", "F", "F", "K", "P", "S"],
            ["A", "O", "O", "T", "T", "W"],
            ["C", "I", "M", "O", "T", "U"],
            ["D", "E", "I", "L", "R", "X"],
            ["D", "E", "L", "R", "V", "Y"],
            ["D", "I", "S", "T", "T", "Y"],
            ["E", "E", "G", "H", "N", "W"],
            ["E", "E", "I", "N", "S", "U"],
            ["E", "H", "R", "T", "V", "W"],
            ["E", "I", "O", "S", "S", "T"],
            ["E", "L", "R", "T", "T", "Y"],
            ["H", "L", "N", "N", "R", "Z"],
            ["H", "I", "M", "N", "U", "Qu"]
    ]
    /// Players custom colors
    var player01 = Player(color: .mint)
    var player02 = Player(color: .orange)
    /// Tiles we want to show on the screen right now
    var tiles = [String]()
    /// We had to import Combine in order to keep track of the following --->
    @Published var timeRemaining = 0.0
    @Published var showingResults = false
    private var timer: AnyCancellable?
    /// <----
    init() {
        reset()
    }
    /// Resets the game by shuffling the dice and reseting the scores
    func reset() {
        tiles = dice.shuffled().map {
            $0.randomElement() ?? "X"
        }
        scores.removeAll()
        player01.reset()
        player02.reset()
        /// Starting our timer
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: update)
        timeRemaining = 180
    }
    /// Ticks down the timer by 1 if the game hasn't ended
    /// - Parameter newTime:
    func update(_ newTime: Date) {
        guard showingResults == false else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            showingResults = true
        }
    }
    /// Tracks to see which player adds each unique word first
    /// assigns that player the score for that word
    /// - Parameters:
    ///   - word: Word being submitted
    ///   - player: Player doing the submitting
    func add(_ word: String, for player: Player) {
        if scores[word] == nil {
            scores[word] = player
        }
    }
}
