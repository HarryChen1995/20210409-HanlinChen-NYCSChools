//
//  SchoolView.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/10/22.
//

import SwiftUI
import MapKit



struct SchoolMapAnnotation: Identifiable {
  let id = UUID()
  var name: String
  var coordinate: CLLocationCoordinate2D

}
struct SchoolDetailView: View {
    
    @State var region:MKCoordinateRegion
    var latitude :Double
    var longitude:Double
    var name: String
    var avgMathScore:Double
    var avgWritingScore:Double
    var avgReadingScore:Double
    var numberOfTesters:Int
    init(name:String, latitude:Double, longitude:Double, avgMathScore:Double, avgWritingScore:Double, avgReadingScore:Double, numberOfTester:Int){
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.avgMathScore = avgMathScore
        self.avgWritingScore = avgWritingScore
        self.avgReadingScore = avgReadingScore
        self.numberOfTesters = numberOfTester
    }
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region,
                annotationItems: [
                SchoolMapAnnotation(name: name, coordinate: CLLocationCoordinate2D(latitude:latitude, longitude:longitude))]){
                school in
                MapPin(coordinate: school.coordinate)
            }
                .frame(width: 400, height: 250)
            Image("schoolicon").resizable().frame(width: 60, height: 60).clipShape(Circle()).overlay {
                Circle().stroke(.gray, lineWidth: 4)}.shadow(radius: 3).offset(y:-35)

            VStack{
                Text("\(name)").font(.headline).fontWeight(.bold)
                Text("Number of Test Takers: \(numberOfTesters)").padding(.top)
                Text("Average Math: \(avgMathScore.roundDoubleToDecimalPlace(decimalPlace: 2))").padding(.top)
                Text("Average Writing: \(avgWritingScore.roundDoubleToDecimalPlace(decimalPlace: 2))").padding(.top)
                Text("Average Critial Reading: \(avgReadingScore.roundDoubleToDecimalPlace(decimalPlace: 2))").padding(.top)
                
           
            }
        
            Spacer()
        }.ignoresSafeArea()
    }
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailView(name: "Clinton School Writers & Artists, M.S. 260", latitude: 40.73653, longitude:  -73.9927, avgMathScore: 300.0, avgWritingScore: 220, avgReadingScore: 220, numberOfTester: 134)
    }
}

extension Double {
    func roundDoubleToDecimalPlace(decimalPlace:Int)->String{
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = decimalPlace
        formatter.minimumFractionDigits = decimalPlace
        if let formattedString = formatter.string(for: self ) {
            return formattedString
        }
        return ""
    }
}
