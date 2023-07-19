//
//  LetterGridView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//

import SwiftUI

struct LetterGridView: View {
    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<16, id: \.self) { index in
                    Text("X")
                }
            }
        }
        /// Makes the grid square at all times
        .aspectRatio(1, contentMode: .fit)
    }
}

struct LetterGridView_Previews: PreviewProvider {
    static var previews: some View {
        LetterGridView()
    }
}
