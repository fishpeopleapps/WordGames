//
//  LetterGridView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//

import SwiftUI

struct LetterGridView: View {
    @ObservedObject var player: Player
    @State private var message: String?
    var game: GameBrain
    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<game.tiles.count, id: \.self) { index in
                    let tile = game.tiles[index]
                    LetterView(
                        letter: tile,
                        isSelected: player.selectedTiles.contains(index),
                        selectionColor: player.color
                    ) {
                        message = player.trySelecting(index, in: game)
                    }
                }
            }
            /// Makes it so users cannot keep playing while there is an error message present
            .disabled(message != nil)
            /// This is like a makeshift alert message!!
            if let message {
                VStack {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.headline)
                    Button("OK", action: dismissMessage)
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.black.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .transition(.scale)
            }
        }
        /// Makes the grid square at all times
        .aspectRatio(1, contentMode: .fit)
    }
    func dismissMessage() {
        withAnimation {
            message = nil
        }
    }
}
