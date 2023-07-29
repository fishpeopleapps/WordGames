//
//  CategoriesView.swift
//  WordGames
//
//  Created by KBrewer on 7/18/23.
//

import SwiftUI

struct CategoriesView: View {
    var categories = Bundle.main.decode([String].self, from: "Categories.json").map {
        Bundle.main.decode(Category.self, from: "\($0).json")
    }
    var body: some View {
        NavigationStack {
            List(categories) { category in
                NavigationLink(value: category) {
                    VStack(alignment: .leading) {
                        Text(category.name)
                            .font(.headline)
                        Text(category.description)
                    }
                }
            }
            .navigationDestination(for: Category.self) { category in
                LevelsView(category: category)
            }
            .navigationTitle("Swift Words")
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
