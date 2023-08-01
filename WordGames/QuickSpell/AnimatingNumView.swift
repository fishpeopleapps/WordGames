//
//  AnimatingNumView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 8/1/23.
//

import SwiftUI

struct AnimatingNumView: View, Animatable {
    var title: String
    var value: Int
    var animatableData: Double {
        get { Double(value) }
        set { value = Int(newValue) }
    }
    var body: some View {
        Text("\(title): \(value)")
    }
}
