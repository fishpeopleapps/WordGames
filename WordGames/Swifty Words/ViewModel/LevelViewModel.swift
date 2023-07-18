//
//  LevelViewModel.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import Foundation

class LevelViewModel: ObservableObject {
    /// Which answers we need and which have been solved (can read externally, but not modify)
    private(set) var answers: [Answer]
    /// Here are the segments in our grid (can read externally, but not modify)
    private(set) var segments: [Segment]
    /// This will store the indexes for the selected segments, directly
    @Published var selectedSegments = [Int]()
    init(words: [Word]) {
        /// Take the answer, wrap it into an answer array (above) so we can get the value of
        /// is solved or not
        answers = words.map(Answer.init)
        /// Get all the segments from all the words and put into a single array, but they
        /// must appear in a random order, then put them into the Segment array above
        segments = words.flatMap(\.segments).shuffled().map(Segment.init)
    }
        /// Either returns a space or the selected segments
        var currentAnswer: String {
            if selectedSegments.isEmpty {
                /// Adding a space so Swift allocates the correct height for the UI
                return " "
            } else {
                /// Still here? convert SelectedSegments Array (above) into the correct segments
                /// We're getting the correct segments, finding the text associated with it, then joining
                /// it back together as an array that makes sense to the user
                return selectedSegments.map { segments[$0].text }.joined()
            }
        }
        /// Takes the selected segment(s), finds an answer match (if there is one)
        /// - Parameter index: The segment selected at a particular index
        func select(_ index: Int) {
            /// Tracks if the user has selected a segment, if yes, do not allow them to reuse it
            segments[index].isUsed = true
            selectedSegments.append(index)
            /// variable is created so we don't have to run the computed property over and over again
            let userAnswer = currentAnswer
            let match = answers.firstIndex {
                $0.word.solution == userAnswer
            }
            if let match {
                selectedSegments.removeAll()
                answers[match].isSolved = true
            }
        }
        /// Remove the last segment selected, and makes it unused
        func delete() {
            if let removed = selectedSegments.popLast() {
                segments[removed].isUsed = false
            }
        }
    }
