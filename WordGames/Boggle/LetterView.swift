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
    var selectTile: () -> Void
    var body: some View {
        Button(action: selectTile) {
            Text(letter)
                .font(.system(size: 44).bold())
        }
    }
}

//struct LetterView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterView()
//    }
//}
