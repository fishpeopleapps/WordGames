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
            BoggleView()
                .tabItem {
                    Label("Boggle", systemImage: "circle.hexagongrid")
                }
            WordScrambleView()
                .tabItem {
                    Label("Scramble", systemImage: "circle.hexagonpath")
                }
            CategoriesView()
                .tabItem {
                    Label("7Words", systemImage: "circle.hexagongrid.circle.fill")
                }
        }
        .tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
