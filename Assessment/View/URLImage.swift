//
//  URLImage.swift
//  SwiftUIDemo
//
//  Created by Gaurang Vyas on 11/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import SwiftUI
import Kingfisher

struct URLImage: SwiftUI.View {
    
    public let animation: Animation = .default
    let imageURL: URL?
    var placeholderImage: UIImage = #imageLiteral(resourceName: "placeholder-image")
    @State private var image: UIImage? = nil

    var body: some SwiftUI.View {
       Image(uiImage: image ?? placeholderImage)
        .resizable()
        .scaledToFill()
        .transition(.opacity)
        .id(image ?? placeholderImage)
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        guard let url = imageURL else{
            return
        }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let imageResult):
                withAnimation(self.animation) {
                    self.image = imageResult.image
                }
            case .failure:
                break
            }
        }
    }
    
}
