//
//  RecipeInfoViewModel.swift
//  SwiftUIDemo
//
//  Created by Gaurang Vyas on 04/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Moya
import ObjectMapper

public class RecipeInfoViewModel: ObservableObject {
    let feedsProvider = MoyaProvider<ReceipesServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
   // public let willChange = PassthroughSubject<RecipeInfoViewModel, Never>()
    public let willChange = PassthroughSubject<RecipeInfoViewModel, Never>()

   // var listdata = [ListData]()

    
    @Published var recipess: [ListData] = [ListData]() {
        didSet {
            willChange.send(self)
        }
    }
    
    @Published var recipes: [RecipeInfo] = [RecipeInfo]() {
        didSet {
            willChange.send(self)
        }
    }
    
    
    func load() {
        feedsProvider.request(.feeds) { result in
            switch result{
            case let .success(response):
                do{
                    let responseStrInISOLatin = String(data: response.data, encoding: String.Encoding.isoLatin1)

                    guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                         print("could not convert data to UTF-8 format")
                         return
                    }
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? [String:Any]
                                   print(responseJSONDict as Any)
                    let dataaaa = responseJSONDict?["rows"] as! NSArray
                    
                    if let popular = Mapper<ListData>().mapArray(JSONObject:dataaaa) {
                        
                        if popular.count != 0 {
                            self.recipess = [ListData]()
                            self.recipess = popular
                            print(self.recipess)
                        }
                    }

//                    let responseDict = try JSONDecoder().decode(Response.self, from: response.data)
//
//                    print(responseDict)
                    
                }catch let error{
                    print(error)
                }
                break
            case let .failure(error):
              //  print(Strings.failure,error)
                break
            }
        }
    }
}

