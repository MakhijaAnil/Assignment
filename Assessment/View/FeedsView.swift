//
//  FeedView.swift
//  SwiftUIDemo
//
//  Created by Gaurang Vyas on 04/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import SwiftUI
import Combine
import Moya

struct FeedsView: View {
    
    @ObservedObject var viewModel: RecipeInfoViewModel
    
    @State var feedsArray: [RecipeInfo] = []
    @State var recipeId:Int = 0
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.recipes,id: \.recipeId) { recipe in
                                            FeedListCell(feed: recipe).padding(.trailing, 16)

                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
            .listStyle(GroupedListStyle())
            .padding(.trailing, -32.0)
            .navigationBarTitle("Welcome")
            
            
        }
        
    }
    
    
}

