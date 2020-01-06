//
//  RecipeInfo.swift
//  My Recipes
//
//  Created by Anil on 05/01/20.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Foundation



//struct Infodata: Codable{
//    let rows :[RecipeInfo
//    let title :String?
//  
//
//}

struct RecipeInfo: Codable{
    let recipeId :Int
    let title :String?
    let imageHref :URL?
    let description :String?

}

struct Response: Codable
{
    struct rows: Codable {
        let recipeId :Int
        let title :[String: String]
        let imageHref :[String: String]
        let description :[String: String]
    }
    
    let title :String?
    let users:[rows]
}


struct rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?

}
//Custom Keys
enum CodingKeys: String, CodingKey{
    case title = "title"
    case description = "description"
    case imageHref = "imageHref"
}


