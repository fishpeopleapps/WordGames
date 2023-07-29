//
//  WordScrambleView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/7/23.
//
// TODO: Move Logic Out

import SwiftUI

struct WordScrambleView: View {
    @FocusState private var isFocused: Bool
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    /// UserScore related state variables, one to hold score, one to change size
    @State private var userScore = 0
    @State private var scoreSize = 16
    /// Incorrect guesses will produce an alert with custom title/message
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    /// View
    var body: some View {
        NavigationView {
            List {
                /// Section that contains the rootWord with custom text
                Section {
                    Text(rootWord)
                        .rootStyle()
                }
                .listRowBackground(Color("Dragonfruit"))
                /// Section that contains the user score
                Section {
                    Text("Your Score: \(userScore)")
                        .frame(maxWidth: .infinity).bold().kerning(1.5)
                        .foregroundStyle(Color("Plum"))
                        .font(.system(size: CGFloat(scoreSize)))
                }
                .listRowBackground(Color("Kiwi"))
                /// Section that contains the textField for users to enter their words
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($isFocused)
                }
                /// Section that displays the user words that count
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                } header: {
                    Text("Your Words")
                } footer: {
                    if usedWords.isEmpty {
                        Text("It looks like you don't have any words yet")
                    }
                }
            }
            .onTapGesture {
                isFocused = false
            }
            .scrollContentBackground(.hidden)
            .background((Color("Kiwi")).edgesIgnoringSafeArea(.all))
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok", role: .cancel) { isFocused = true }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        startGame()
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundStyle(Color("Dragonfruit"))
                    }
                }
            }
        }
    }
    func addNewWord() {
        /// lowercase the correct word string and remove whitespaces
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        /// word validation
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
        /// insert word at position 0 in used words array so it appears at the top
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        /// Increase the user score, refocus the view onto the empty textField
        increaseScore()
        newWord = ""
        isFocused = true
    }
    /// Increases the user score which is stored in AppStorage and is culminated from every word
    func increaseScore() {
        let wordScore = newWord.count
        withAnimation {
            scoreSize = 20
            userScore += wordScore
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                scoreSize = 16
            }
        }
    }
    func startGame() {
        /// If we have found start.txt in our app bundle, continue...
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            /// Load the file into startWords
            if let startWords = try? String(contentsOf: startWordsURL) {
                /// split it on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                /// give us a random word
                rootWord = allWords.randomElement() ?? "silkworm"
                /// move the focus to the textfield
                isFocused = true
                /// empty the usedWords array when starting a new word
                usedWords.removeAll()
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    /// Determines if the word is large enough to score (3 or more)
    func isLongEnough(word: String) -> Bool {
        if newWord.count < 3 {
            return false
        }
        return true
    }
    /// Determines if the user has already used that particular word
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    /// Determines if the user submitted word can be made from the root word
    func isPossible(word: String) -> Bool {
        var tempRootWord = rootWord
        for letter in word {
            /// where is the first place that letter exists
            if let position = tempRootWord.firstIndex(of: letter) {
                /// if we found it, remove it so they can't reuse it
                tempRootWord.remove(at: position)
            } else {
                /// a letter wasn't found so return false
                return false
            }
        }
        return true
    }
    /// Determines if the word the user submits is an actual word
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
    /// Sets up the error alert to show the appropriate error
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
