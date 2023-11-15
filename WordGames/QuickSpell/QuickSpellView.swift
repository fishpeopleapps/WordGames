//
//  QuickSpellView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 8/1/23.
//
// TODO: Move logic out
// TODO: This is designed to only work in landscape!!
// TODO: Add animation when the score is increased (like a +## and then score updates)
// TODO: UI - better, but it's jumpy and the usedLetters can go off screen
// TODO: BUG - it alerts the user game over when the game first starts (since the time is at 0)
// TODO: BUG - There is a random tile with no character and extra padding not sure what the hell it is 
/// maybe go with geometry reader....
/// His recommended todos: subtract points for using duplicate words? Include average letter count? Include completed words?
/// don't

import SwiftUI

struct QuickSpellView: View {
    /// Make 8 random letters, and put it into this array:
    @State private var unusedLetters = [Letter]()
    /// Empty letter array that will have used letters flow in and out of it
    @State private var usedLetters = [Letter]()
    /// All the words we plan to load and show in our game
    @State private var qsDictionary = Set<String>()
    /// whoa!
    @Namespace private var animation
    /// This is to remove unwanted spacers when the dynamic type gets really big
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var qsTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var qsTime = 0
    @State private var qsScore = 0
    @State private var usedWords = Set<String>()
    @State private var isGameOver = false
    var body: some View {
        ZStack {
            VStack {
                if dynamicTypeSize < .accessibility1 {
                    Spacer()
                }
                HStack {
                    ForEach(usedLetters) { letter in
                        // TODO: Make this appear on 2 lines (on iPhone)
                        QSLetterView(
                            letter: letter,
                            color: wordIsValid() ? .teal : .pink,
                            onTap: remove
                        )
                        .matchedGeometryEffect(id: letter, in: animation)
                    }
                }
                HStack(spacing: 10) {
                    VStack(spacing: 5) {
                        ForEach(unusedLetters) { letter in
                            QSLetterView(letter: letter, color: .orange, onTap: add)
                                .matchedGeometryEffect(id: letter, in: animation)
                        }
                    }
                    VStack {

                        HStack {
                            VStack(spacing: 10) {
                                
                                Button("Submit", action: submit)
                                    .disabled(wordIsValid() == false)
                                    .opacity(wordIsValid() ? 1 : 0.33)
                                    .bold()
                                AnimatingNumView(title: "Time", value: qsTime)
                                AnimatingNumView(title: "Score", value: qsScore)
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 5)
                            .monospacedDigit()
                            .font(.title)
                            Spacer()
                        }

                    }
        Spacer()

                }
                if dynamicTypeSize < .accessibility1 {
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
        }
        .background(.blue.gradient) // what!?!?!?
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
       .onAppear(perform: newGame)
       .onReceive(qsTimer) { _ in
           if qsTime == 0 {
               isGameOver = true
           } else {
               qsTime -= 1
           }
       }
       .alert("Game Over!", isPresented: $isGameOver) {
           Button("Play Again", action: newGame)
       } message: {
           Text("Your score was: \(qsScore)")
       }
    }
    func add(_ letter: Letter) {
       /// Check to see if the letter is available for use
        guard let index = unusedLetters.firstIndex(of: letter) else {
            // TODO: shouldn't we provide an error for the user letting them know the letter isn't available?
            return
        }
        withAnimation(.spring()) {
            /// Letter IS available, remove it from the unusedLetters array
            unusedLetters.remove(at: index)
            /// Move it to the used letter array
            usedLetters.append(letter)
        }
    }
    func remove(_ letter: Letter) {
        /// Check to see if the letter is available to remove
         guard let index = usedLetters.firstIndex(of: letter) else {
             // TODO: shouldn't we provide an error for the user letting them know the letter isn't available?
             return
         }
        withAnimation(.spring()) {
            /// Letter IS available, remove it from the uusedLetters array
            usedLetters.remove(at: index)
            /// Move it to the unused letter array
            unusedLetters.append(letter)
        }
    }
    func wordIsValid() -> Bool {
        let word = usedLetters.map(\.character).joined().lowercased()
        // bail out if they've used this word already
        guard usedWords.contains(word) == false else { return false }
        // otherwise return a validated word
        return Dictionary.contains(word)
    }
    /// Wipes the slate clean
    func newGame() {
        qsTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        isGameOver = false
        qsTime = 30
        qsScore = 0
        unusedLetters = (0..<9).map { _ in Letter() }
        usedLetters.removeAll()
    }
    func submit() {
        // Is the word valid?
        guard wordIsValid() else { return } // maybe give them an error here?
        withAnimation {
            let word = usedLetters.map(\.character).joined().lowercased()
            // don't let them use this word again in the future
            usedWords.insert(word)
            // it's squared to give a high incentive to get longer words
            qsScore += usedLetters.count * usedLetters.count
            // and give them more time
            qsTime += usedLetters.count * 2
            //
            unusedLetters.append(contentsOf: (0..<usedLetters.count).map { _ in Letter() })
            usedLetters.removeAll()
        }
    }
}

struct QuickSpellView_Previews: PreviewProvider {
    static var previews: some View {
        QuickSpellView()
    }
}
