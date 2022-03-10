//
//  SAT.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/10/22.
//

import SwiftUI

struct SAT: Codable, Identifiable {
    var id:String
    var numberOfTestTakers:Int = 0
    var avgMathScore:Double = 0
    var avgReadingScore:Double = 0
    var avgWritingScore:Double = 0
    
    enum CodingKeys: String , CodingKey {
        case id  = "dbn"
        case  numberOfTestTakers = "num_of_sat_test_takers"
        case avgMathScore = "sat_math_avg_score"
        case avgReadingScore = "sat_critical_reading_avg_score"
        case avgWritingScore = "sat_writing_avg_score"
    }
    
    init(from decoder :Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id =  try container.decode(String.self, forKey: .id)
        if let numberOfTestTakersStr = try? container.decode(String.self, forKey: .numberOfTestTakers), let numberOfTestTakersInt = Int(numberOfTestTakersStr){
            numberOfTestTakers = numberOfTestTakersInt
        }
        if let avgMathScoreStr = try? container.decode(String.self, forKey: .avgMathScore), let avgMathScoreDouble = Double(avgMathScoreStr){
             avgMathScore = avgMathScoreDouble
        }
        
        if let avgReadingScoreStr = try? container.decode(String.self, forKey: .avgReadingScore), let avgReadingScoreDouble = Double(avgReadingScoreStr){
             avgReadingScore = avgReadingScoreDouble
        }
        
        if let avgWritingScoreStr = try? container.decode(String.self, forKey: .avgWritingScore), let avgWritingScoreDouble = Double(avgWritingScoreStr){
             avgWritingScore = avgWritingScoreDouble
        }
        
    }
}

