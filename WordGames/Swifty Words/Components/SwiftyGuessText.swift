//
//  SwiftyGuessText.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/18/23.
//

import SwiftUI

struct SwiftyGuessText: View {
    var text: String
    /// Provides a text view of the input area where users are guessing segments
    var body: some View {
        Text(text)
            .font(.title)
            .lineLimit(1)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quaternary)
            .cornerRadius(8)

    }
}
