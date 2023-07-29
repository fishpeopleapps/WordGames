//
//  LevelsView.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import SwiftUI

struct LevelsView: View {
    var category: Category
    var body: some View {
        List(0..<category.levels.count, id: \.self) { num in
            NavigationLink(value: num) {
                Text("Level \(num + 1)")
            }
        }
        .navigationDestination(for: Int.self) { level in
            SwiftyWordsView(category: category, levelNumber: level)
        }
        .navigationTitle("Choose a Level")
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView(category: .example)
    }
}
