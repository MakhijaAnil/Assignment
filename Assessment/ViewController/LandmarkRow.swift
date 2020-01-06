//  LandmarkRow.swift
//  Exercise
//
//  Created by Anil on 18/12/19.
//  Copyright © 2019 Anil. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: ListData

    var body: some View {
        HStack {
//            landmark.imageHref
//                .resizable()
//                .frame(width: 70, height: 70)
//                .clipShape(Circle())
            VStack(){
                Text(verbatim: landmark.title! as String).font(.headline)
                Text(verbatim: landmark.description! as String).font(.subheadline)
            }
            Spacer()
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

//struct LandmarkRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LandmarkRow(landmark: ListData[0])
//            LandmarkRow(landmark: ListData[0])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
