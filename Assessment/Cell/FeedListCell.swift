//
//  FeedListCell.swift
//  SwiftUIDemo
//
//  Created by Gaurang Vyas on 04/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import SwiftUI
import UIKit

struct FeedListCell : SwiftUI.View {
    
    var feed: RecipeInfo
    
    var body: some SwiftUI.View {
        VStack(alignment: .leading, spacing: nil) {
            URLImage(imageURL: feed.imageHref)
                .frame(height: 150)
                .clipped()
            Text("PASTA")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 0, trailing: 12))
            Text(feed.title ?? "")
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
           // RecipeMesureView(preparationTime: feed.preparationTime, complexity: feed.complexity, serves: feed.serves)
        }
        .background(Color.white)
        .cornerRadius(6)
    }
}

struct IconTextStack: SwiftUI.View {
    var icon: UIImage
    var text: String
    var body: some SwiftUI.View {
        HStack(spacing:4){
            Image(uiImage: icon)
            Text(text).font(.subheadline).foregroundColor(.gray)
        }
    }
}
