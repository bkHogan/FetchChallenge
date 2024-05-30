//
//  MealListView.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import SwiftUI

// View to display the list of meals
struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading meals...")
                } else {
                    List(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                            // Display each meal in a row
                            MealRow(meal: meal)
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                // Fetch meals when the view appears
                viewModel.fetchMeals()
            }
        }
    }
}

// View for each meal row in the list
struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            if let urlString = meal.strMealThumb, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            }
            Text(meal.strMeal)
                .font(.headline)
        }
    }
}
