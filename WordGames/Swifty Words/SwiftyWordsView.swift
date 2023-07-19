//
//  SwiftyWordsView.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//
// TODO: Improve UI
// TODO: Start at level 1 and automatically increase when the user finishes a level (remove levels view)
// TODO: Refactor categoriesView so it makes sense in the tab view
// TODO: More Comments

import SwiftUI

struct SwiftyWordsView: View {
    @StateObject private var model: LevelViewModel
    var category: Category
    var levelNumber: Int
    /// This is a temporary hack
    init(category: Category, levelNumber: Int) {
        self.category = category
        self.levelNumber = levelNumber
        _model = StateObject(wrappedValue: {
            LevelViewModel(words: category.levels[levelNumber])
        }())
    }
    var body: some View {
        VStack {
            /// Clues
            VStack {
                ForEach(model.answers) { answer in
                    HStack {
                        if answer.isSolved {
                            Text(answer.word.solution)
                        } else {
                            Text(answer.word.hint)
                            Spacer()
                            Image(systemName: answer.imageName)
                        }
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold(answer.isSolved)
                    /// Added so it looks nicer on bigger screens and conforms well to smaller screens
                    Spacer()
                }
            }
            SwiftyGuessText(text: model.currentAnswer)
                .overlay(alignment: .trailing) {
                    Button(action: model.delete) {
                        Label("Delete", systemImage: "delete.left")
                            .font(.title)
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.plain)
                    .offset(x: -10)
                }
            Spacer()
            /// Segments
            LazyVGrid(columns: Array<GridItem>(repeating:
                    .init(.flexible()), count: 4)) {
                        ForEach(0..<model.segments.count, id: \.self) { index in
                            let segment = model.segments[index]
                            Button {
                                model.select(index)
                            } label: {
                                SegmentView(segment: segment)
                            }
                            .buttonStyle(.plain)
                            .disabled(segment.isUsed)
                            .disabled(model.selectedSegments.count == 7)
                        }
                    }
        }
        .padding()
        .navigationTitle("Level \(levelNumber + 1)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwiftyWordsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftyWordsView(category: .example, levelNumber: 0)
    }
}
