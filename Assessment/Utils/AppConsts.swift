//
//  AppConsts.swift
//  My Recipes
//
//  Created by Anil on 05/01/20.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import UIKit

enum AppConsts {
    static let appDel = UIApplication.shared.delegate as! AppDelegate
    static let sceneDel = UIApplication.shared.delegate!.window!!.windowScene?.delegate as? SceneDelegate
}

enum URLPath{
    
    static let APIBaseURL           = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

   
    static let feeds                = ""
    
}

