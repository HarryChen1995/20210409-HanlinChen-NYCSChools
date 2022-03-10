//
//  SchoolViewModel.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import  SwiftUI


enum NYCFetchResult  {
    case schoolInfo (Result<[School], APIError>)
    case satScore(Result<[SAT], APIError>)
}

@MainActor
class SchoolViewModel : ObservableObject {
    
    @Published var schools :[School] = []
    @Published var satScores: [SAT] = []
    @Published var error:APIError?
    init(){
        Task {
            await fetchAllDataInParallel()
        }
    }

    func fetchAllDataInParallel() async {
        let _ = await withTaskGroup(of: NYCFetchResult.self){
            group in
            group.addTask {
                let result = await SchoolAPIHelper.fetchSchoolInfo()
                return  .schoolInfo(result)
                
                
            }
            group.addTask {
                let result = await SchoolAPIHelper.fetchSATScore()
                return .satScore(result)
            }
            
            for await taskResult in group {
                switch  taskResult {
                case .schoolInfo(let schoolInfosResult):
                    if  case  let .success(data) = schoolInfosResult{
                        schools = data
                    }
                    if case let .failure(apiError) = schoolInfosResult {
                        error = apiError
                    }
                case .satScore(let satsResult):
                    if  case  let .success(data) = satsResult{
                        satScores = data
                    }
                    if case let .failure(apiError) = satsResult {
                        error = apiError
                    }
                }
            }
        }
        
    }
    
    
    
    
    func fetchSATSCores () async {
        schools = []
        let fetchedSATScores = await SchoolAPIHelper.fetchSATScore()
        
        switch fetchedSATScores {
        case .failure(let apiError):
            error = apiError
        case .success(let satResults):
            satScores = satResults
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
    
    
    func getSATScoreById(id:String) -> SAT?{
        return satScores.first(where: { $0.id == id})
    }
}
