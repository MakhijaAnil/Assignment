//
//  ListData.swift
//  Exercise
//
//  Created by Anil on 05/01/20.
//  Copyright © 2019 Anil. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class ListData: Mappable {
    
    var title: NSString?
    var imageHref: NSString?
    var description: NSString?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
         title <- map["title"]
        imageHref <- map["imageHref"]
         description <- map["description"]
    }
    

}
