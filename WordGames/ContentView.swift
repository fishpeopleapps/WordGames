//
//  ContentView.swift
//  WordGames
//
//  Created by KBrewer on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WordScrambleView()
                .tabItem {
                    Label("Scramble", systemImage: "circle.hexagonpath")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
