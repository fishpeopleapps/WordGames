//
//  ContentView.swift
//  WordGames
//
//  Created by KBrewer on 7/7/23.
//
// TODO: Make this work on iPad
// TODO: May need to save the user info in a way that means we need cloud kit? data controller?
// TODO: List on premium features, proposed pay model
// TODO: make branding cohesive
// TODO: Haptics, Animations, Accessibility, Oh My!
// TODO: Add some sounds :) 

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CategoriesView()
                .tabItem {
                    Label("Account", systemImage: "circle.hexagongrid.circle.fill")
                }
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
            QuickSpellView()
                .tabItem {
                    Label("QuickSpell", systemImage: "circle.hexagongrid.circle.fill")
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
