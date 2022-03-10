//
//  SchoolViewModel.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import  SwiftUI


@MainActor
class SchoolViewModel : ObservableObject {
    
    @Published var schools :[School] = []
    @Published var error:APIError?
    init(){
        Task {
            await fetchSchools()
        }
    }
    
  
    func fetchSchools () async {
        schools = []
        let fetchedSchools = await SchoolAPIHelper.fetchSchoolInfo()
        
        switch fetchedSchools {
        case .failure(let apiError):
            error = apiError
        case .success(let schoolResults):
            schools = schoolResults
        }
        
    }
    
    func sortSchoolsByStudentNumber() {
        schools.sort { $0.totalStudents > $1.totalStudents}
    }
}
