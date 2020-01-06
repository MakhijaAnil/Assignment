//
//  Modifiers.swift
//  SwiftUIDemo
//
//  Created by Gaurang Vyas on 10/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import SwiftUI

struct PrimaryTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .border(Color(.lightGray), width: 1)
    }
}

struct PrimaryButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 40)
        .foregroundColor(.white)
        .opacity(configuration.isPressed ? 0.5 : 1.0)
        .background(LinearGradient(gradient: Gradient(colors: Color.gradientColors), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(20)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
  }

}

extension Color {
    
    static var gradientColors: [Color] {
        return [Color.primaryColor, Color.primaryDarkColor]
    }
    
    static var primaryColor: Color {
        return Color(#colorLiteral(red: 0.9993464351, green: 0.532096386, blue: 0.01728049107, alpha: 1))
    }
       
    static var primaryDarkColor: Color {
        return Color(#colorLiteral(red: 0.9244950414, green: 0.322776556, blue: 0.009406579658, alpha: 1))
    }
}
