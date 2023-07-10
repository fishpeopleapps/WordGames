//
//  WordScrambleView.swift
//  WordGames
//
//  Created by KBrewer on 7/7/23.
//
// TODO: Move some of the logic out
// TODO: Add code comments
// TODO: Make the UI pretty
// TODO: I could make this timed?
// TODO: Add a success sound if they ___? get a word? reach a point goal?
// TODO: Get rid of the enum

import SwiftUI

struct WordScrambleView: View {
    enum FocusedField {
        case nextWord
    }
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var userScore = 0
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @FocusState private var focusedField: FocusedField?
    var body: some View {
        NavigationView {
            List {
                Text("Your Score: \(userScore)")
                Section {
                 //   TextField("Enter your word", text: $newWord)
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .nextWord)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }

                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok", role: .cancel) { focusedField = .nextWord }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        startGame()
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
    func addNewWord() {
        // lowercase the correct word string and remove whitespaces
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // check it has at least one character
        // give the person a message saying their attempt has to be longer
        guard answer.count > 2 else { return }
        // more validation
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Shoot for 3 letter words or higher, you got this!")
            return
        }
        // insert word at position 0 in used words array
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        // increase userScore
        increaseScore()
        // set newWord to be an empty string
       // newWord = ""
        newWord = ""
        // refocus the view to the textfield
        focusedField = .nextWord
    }
    func increaseScore() {
        let wordScore = newWord.count
        userScore += wordScore
    }
    func startGame() {
        // If we have found start.txt in our app bundle, continue...
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Load the file into startWords
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split it on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // give us a random element
                rootWord = allWords.randomElement() ?? "silkworm"
                // move the focus to the textfield
                focusedField = .nextWord
                usedWords = []
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    func isLongEnough(word: String) -> Bool {
        if newWord.count < 3 {
            return false
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool {
        var tempRootWord = rootWord
        for letter in word {
            // where is the first place that letter exists
            if let position = tempRootWord.firstIndex(of: letter) {
                // if we found it, remove it so they can't reuse it
                tempRootWord.remove(at: position)
            } else {
                // a letter wasn't found so return false
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct WordScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}
