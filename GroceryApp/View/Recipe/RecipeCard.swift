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
    @State private var selectedTab = 0
    @State var playVideo: Bool = false
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    KFImage(URL(string: recipe.thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .cornerRadius(10)
                        .accessibilityIdentifier("recipeImage")
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 150)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.origin)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange)
                            .cornerRadius(20)
                            .accessibilityIdentifier("recipeOrigin")

                        Text(recipe.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .accessibilityIdentifier("recipeName")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                HStack(spacing: 20) {
                    FavoriteButton(recipe: recipe)
                    Spacer()
                    Button {
                        if let youtubeURL = recipe.youtube, let url = URL(string: youtubeURL) {
                            print(youtubeURL)
                            coordinator.navigate(to: Destination.videoPlayer(url))
                        }
                    } label: {
                        Label("Watch", systemImage: "play.circle.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.red)
                            .clipShape(Capsule())

                    }
//                    if let youtubeURL = recipe.youtube, let url = URL(string: youtubeURL) {
//                        Link(destination: url ) {
//                            Label("Watch", systemImage: "play.circle.fill")
//                                .font(.subheadline.bold())
//                                .foregroundStyle(.white)
//                                .padding(.horizontal, 16)
//                                .padding(.vertical, 10)
//                                .background(Color.red)
//                                .clipShape(Capsule())
//                        }
//                        .accessibilityIdentifier("youtubeLink")
//                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                VStack(spacing: 0) {
                    HStack {
                        TabButton(title: "Ingredients", index: 0, selectedTab: $selectedTab)
                        TabButton(title: "Instructions", index: 1, selectedTab: $selectedTab)
                    }
                    if selectedTab == 0 {
                        IngredientsView(ingredients: recipe.ingredients)
                    } else {
                        InstructionsView(instructions: recipe.instructions)
                    }
                                    }
                Spacer(minLength: 60)
            }
        }
        .accessibilityIdentifier("recipeCardScrollView")
        .edgesIgnoringSafeArea(.top)
        .background(Color(.systemBackground))
    }
}
