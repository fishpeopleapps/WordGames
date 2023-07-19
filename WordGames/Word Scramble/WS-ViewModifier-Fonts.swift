//
//  WS-ViewModifier-Fonts.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/19/23.
//

import SwiftUI

struct RootWord: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Monoton", size: 45))
            .textCase(.uppercase)
            .foregroundStyle(Color.white)
            .frame(width: 500)
    }
}

extension View {
    func rootStyle() -> some View {
        modifier(RootWord())
    }
}
