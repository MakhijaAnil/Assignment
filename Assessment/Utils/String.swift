//
//  String.swift
//  My Recipes
//
//  Created by Anil on 05/01/20.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Foundation

extension String{
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}

