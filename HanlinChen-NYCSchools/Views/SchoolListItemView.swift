//
//  SchoolListItemView.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import SwiftUI

struct SchoolListItemView: View {
    var schoolName: String
    var studentNumber:Int
    var graduationRate:String
    var body: some View {

        HStack {
            
            Image("schoolicon").resizable().frame(width: 60, height: 60).clipShape(Circle()).overlay {
                Circle().stroke(.gray, lineWidth: 4)}.shadow(radius: 3).padding()
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(schoolName)").font(.headline).allowsTightening(true).padding(.bottom)
                VStack(alignment:.trailing){
                    Text("graduation rate: \(graduationRate)").font(.system(size: 11)).foregroundColor(.gray).fontWeight(.bold).padding(.bottom,2)
                    Text("total students: \(studentNumber)").font(.system(size: 11)).foregroundColor(.gray).fontWeight(.bold)
                }
            }
        }.padding(.horizontal)
   

    }
}

struct SchoolListItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        SchoolListItemView(
            schoolName: "Clinton School Writers & Artists, M.S. 260",
            studentNumber: 2000,
            graduationRate: "50.23%"
        ).multilineTextAlignment(.leading)
    }
}
