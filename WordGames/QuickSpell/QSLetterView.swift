//
//  QSLetterView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 8/1/23.
//
// TODO: Put Q + U together? this might be a bit difficult as we would have to use a string as opposed to a character
import SwiftUI

struct QSLetterView: View {
    /// What letter does it plan to store? What letter is showing?
    let letter: Letter
    var color: Color
    /// THIS IS THE THING RIGHT HERE -->
    /// Property that stores the closure to run when the letter is tapped!!
    var onTap: (Letter) -> Void
    /// This is to handle dynamic type!!!!
    @ScaledMetric(relativeTo: .largeTitle) var size = 60
    var body: some View {
        Button {
            onTap(letter)
        } label: {
            ZStack {
                // TODO: This might be the way to change the boggle letters!
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.gradient)
                    .frame(width: size)
                    .frame(minHeight: size / 2, maxHeight: size)
                   // .frame(width: size, height: size)
                    .shadow(radius: 3)
                Text(letter.character)
                    .foregroundStyle(.white.opacity(0.65))
                    .font(.largeTitle.bold())
            }
        }
        /// This is so the view doesn't say "Capital _" every time
        .accessibilityLabel(letter.character.lowercased())
    }
}

struct QSLetterView_Previews: PreviewProvider {
    static var previews: some View {
        QSLetterView(letter: Letter(), color: .mint) { _ in
            // this is for the onTap
        }
    }
}
