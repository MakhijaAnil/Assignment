//
//  RecipesServices.swift
//  My Recipes
//
//  Created by Anil on 05/01/20.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Foundation

import Moya

enum ReceipesServices {
    case feeds
    
}

extension ReceipesServices: TargetType {
    var task: Task {
        switch self {
        case .feeds:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: URLPath.APIBaseURL)! }
    
    var path: String {
        switch self {
        case .feeds:
            return URLPath.feeds
        
        }
     }
    
    var method: Moya.Method {
        switch self {
        case .feeds:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}


