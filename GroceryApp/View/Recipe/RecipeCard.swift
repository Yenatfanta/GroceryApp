//
//  RecipeCard.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/4/25.
//

import SwiftUI
import Kingfisher
struct RecipeCard: View {
    var recipe: RecipeDetail
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(recipe.origin)
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    
                }
                .padding(.horizontal)
                KFImage(URL(string: recipe.thumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .cornerRadius(10)
                if let youtubeURL = recipe.youtube {
                    Link(destination: URL(string: youtubeURL)!) {
                        HStack {
                            Image(systemName: "play.circle")
                            Text("Watch on YouTube")
                        }
                        .foregroundStyle(.blue)
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text(ingredient.ingredient)
                            Spacer()
                            Text(ingredient.measure)
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        Divider()
                    }
                }
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                    ForEach(Array(recipe.instructions.split(separator: "\r\n")
                        .enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top) {
                                Text("\(index + 1).")
                                    .foregroundColor(.gray)
                                Text(String(instruction))
                            }
                            .padding(.vertical, 4)
                        }
                }
                .padding(.horizontal)
            }
        }
    }
}
