//
//  BoggleView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//
// TODO: Add a button to reset the game nad 'reroll'
// TODO: Improve UI
// TODO: Bug with the error staying if the game ends, move it to the player class
// TODO: What is a 'Splash Screen'
// TODO: Make an AI version so users can play against a machine with levels

import SwiftUI

struct BoggleView: View {
    @StateObject private var game = GameBrain()
    var timeRemainingText: Text {
        if game.timeRemaining > 0 {
            return Text(Date.now.addingTimeInterval(game.timeRemaining), style: .timer)
        } else {
            return Text("0:00")
        }
    }
    var body: some View {
        ZStack {
            VStack(spacing: 60) {
                LetterGridView(player: game.player02, game: game)
                    .rotationEffect(.degrees(180))
                LetterGridView(player: game.player01, game: game)
            }
            .padding(10)
            HStack {
                Spacer()
                timeRemainingText
                Spacer()
                timeRemainingText
                    .rotationEffect(.degrees(180))
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.system(size: 36).monospacedDigit())
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(.indigo)
        }
        .sheet(isPresented: $game.showingResults, onDismiss: game.reset) {
            ResultsView(game: game)
        }
    }
}

struct BoggleView_Previews: PreviewProvider {
    static var previews: some View {
        BoggleView()
    }
}
