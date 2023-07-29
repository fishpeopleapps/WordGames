//
//  Player.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//

import SwiftUI

class Player: ObservableObject {
    /// Holds the words that have been used by each player
    var usedWords = [String]()
    /// Each player will have a distinct color to help differentiate the two players
    var color: Color
    /// Holds the indexes of the selected tiles - currently selected tile locations
    @Published var selectedTiles = [Int]()
    init(color: Color) {
        self.color = color
    }
    /// Restarts the game by removing all selected tiles and used words
    func reset() {
        selectedTiles.removeAll()
        usedWords.removeAll()
    }
    /// handles selecting individual tiles on our game board, talks to GameBrain to
    /// relay to it who selected the word first
    func trySelecting(_ index: Int, in game: GameBrain) -> String? {
        /// If they have 3 or more tiles selected, submit the word for review
        if selectedTiles.last == index && selectedTiles.count >= 3 {
            return submit(in: game)
        }
        if let indexLocation = selectedTiles.firstIndex(of: index) {
            /// If they only have one tile selected, we're going to deselect the tile on tap
            if selectedTiles.count == 1 {
                selectedTiles.removeLast()
            } else {
                /// If they have more than one tile selected, we'll remove up to the point where they select
                /// example, if they select I in SWIFT, it will remove IFT
                selectedTiles.removeLast(selectedTiles.count - indexLocation - 1)
            }
        } else {
            tryAppending(index)
        }
        return nil
    }
    /// See if it is possible to append the tile based on its location
    /// - Parameter newIndex: Takes the index of the tile the user is trying to select for comparison
    func tryAppending(_ newIndex: Int) {
        /// If we are here, they haven't selected a tile yet and we will append the first tile they select
        guard let lastIndex = selectedTiles.last else {
            selectedTiles.append(newIndex)
            return
        }
        /// This tells us the row and column of the previous tile and the new tile
        let lastPosition = (row: lastIndex / 4, col: lastIndex % 4)
        let newPosition = (row: newIndex / 4, col: newIndex % 4)
        /// Now we're going to figure out how far apart they are
        let positionDifference = (
            row: abs(newPosition.row - lastPosition.row),
            col: abs(newPosition.col - lastPosition.col)
        )
        /// Determines if the new tile is in the correct position
        if max(positionDifference.row, positionDifference.col) == 1 {
            selectedTiles.append(newIndex)
        }
    }
    func submit(in game: GameBrain) -> String? {
        /// Get the letters from the indexes and join them together to make a word
        let word = selectedTiles.map { game.tiles[$0] }.joined().lowercased()
        /// Have they used the word already?
        guard usedWords.contains(word) == false else {
            return "You used that word already!"
        }
        if Dictionary.contains(word) {
            /// Success! They have a unique word, put it into their usedWord array
            usedWords.append(word)
            game.add(word, for: self)
            print("I have been added")
            selectedTiles.removeAll()
            print("I have been removed")
        } else {
            return "That isn't a valid word"
        }
        return nil
    }

}
