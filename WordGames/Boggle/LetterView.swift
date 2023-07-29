//
//  LetterView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    var isSelected = false
    var selectionColor: Color
    var selectTile: () -> Void // this is how we pass in a function...!
    var body: some View {
        Button(action: selectTile) {
            Text(letter)
                .font(.system(size: 44).bold()) // best size for fitting on all screen sizes
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(15) // TODO: this isn't working
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(isSelected ? selectionColor : Color.gray.opacity(0.25))
                .aspectRatio(1, contentMode: .fit) // creates a square
                .animation(nil, value: isSelected) // forces animation off
        }
        .buttonStyle(.plain)
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letter: "X", selectionColor: .mint) {
            // do nothing
        }
    }
}
