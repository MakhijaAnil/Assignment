//  LandmarkList.swift
//  Exercise
//
//  Created by Anil on 18/12/19.
//  Copyright © 2019 Anil. All rights reserved.
//

import SwiftUI
import ObjectMapper
import Alamofire

var listdata = [ListData]()


struct LandmarkList: View {
    
   // @ObservedObject var viewModel: RecipeInfoViewModel

    @ObservedObject var viewModel = RecipeInfoViewModel()

    // @ObservedObject var obs = observer()


    var body: some View {
        
        NavigationView {
            List(viewModel.recipess.dropLast()){ datainfo in
                
                                   print(gcList)

               // NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                   // LandmarkRow(landmark: ListData)
              //  }
            }.navigationBarTitle(Text("List"))
        }
    }
}

//struct LandmarkList_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["iPhone XS Max"], id: \.self) { deviceName in
////            LandmarkList()
////                .previewDevice(PreviewDevice(rawValue: deviceName))
////                .previewDisplayName(deviceName)
////        }
//    }
//}
/* ViewModel
extension LandmarkList {
    
    class ViewModel: ObservableObject {
        
        @Published private(set) var countries: [ListData] = []
        
        private let service: LandmarkList.callGetPopularPost()
        
        func loadCountries() {
            service.getCountries { [weak self] result in
                self?.countries = result.value ?? []
            }
        }
    }
}*/

