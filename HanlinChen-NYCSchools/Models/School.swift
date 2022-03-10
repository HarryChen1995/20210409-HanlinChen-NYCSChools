//
//  School.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import SwiftUI

struct School:  Codable , Identifiable{
    var id:String
    var schoolName:String
    var overviewParagraph:String
    var totalStudents:Int
    var schoolSports: String
    var latitude:Float = 0.0
    var longitude:Float = 0.0
    var graduationRate:String  = "NA"
    enum CodingKeys: String, CodingKey {
            case latitude
            case longitude
            case id = "dbn"
            case schoolName = "school_name"
            case  overviewParagraph = "overview_paragraph"
            case totalStudents = "total_students"
            case schoolSports = "school_sports"
            case graduationRate = "graduation_rate"
    }
    
    init(from decoder:Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        
        id =  try container.decode(String.self, forKey: .id)
        schoolName = try container.decode(String.self, forKey: .schoolName)
        overviewParagraph = try container.decode(String.self , forKey: .overviewParagraph)
        let  totalStudentsStr = try container.decode(String.self, forKey: .totalStudents)
         totalStudents =  Int(totalStudentsStr)  ?? 0
        schoolSports = try container.decode(String.self, forKey: .totalStudents)
        
        if let latitudeStr = try? container.decode(String.self, forKey: .latitude), let latitudeFloat = Float( latitudeStr){
            latitude = latitudeFloat
        }
    
        if  let longitudeStr = try?  container.decode(String.self, forKey: .longitude) , let longitudeFloat = Float( longitudeStr) {
            longitude =  longitudeFloat
        
    }
        
        if let gradRateStr = try? container.decode(String.self, forKey: .graduationRate), let gradRateFloat = Float( gradRateStr){
            graduationRate = gradRateFloat.roundPercentageToDecimalPlace(decimalPlace: 2)
        }
    }
    
    
}

extension Float {
    func roundPercentageToDecimalPlace(decimalPlace:Int)->String{
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = decimalPlace
        formatter.minimumFractionDigits = decimalPlace
        if let formattedString = formatter.string(for: self * 100) {
            return formattedString  + "%"
        }
        return ""
    }
}
