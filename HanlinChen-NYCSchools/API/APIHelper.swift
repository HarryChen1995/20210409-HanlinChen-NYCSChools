//
//  APIHelper.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import SwiftUI


enum APIError:Error {
    case ForbiddenError
    case UnAuthorizedError
    case RefusedConnectionError
    case NotFoundError
    case InternalSeverError
}

extension HTTPURLResponse {
    
    static func getAPIErrorFromResponse(response:URLResponse) -> APIError?{
        
        if let response = response as? HTTPURLResponse , response.statusCode ==  404 {
            return .NotFoundError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 401 {
            return .UnAuthorizedError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 403 {
            return .ForbiddenError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 500 {
            return .InternalSeverError
        }
        
        return nil
    }
}

class SchoolAPIHelper {
    static func fetchSchoolInfo() async  ->  Result< [School], APIError>{
        let schoolInfoUrl  = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        do {
            let url = URL(string: schoolInfoUrl)
            let ( data, response) = try await URLSession.shared.data(from: url!)
            if let  error  =  HTTPURLResponse.getAPIErrorFromResponse(response: response)  {
                return .failure(error)
            }
            
            let schools = try! JSONDecoder().decode([School].self,  from: data)
            return .success(schools)
        }
        catch(let error){
            print(error.localizedDescription)
        }
        return .failure(.RefusedConnectionError)
    }
    
    
}
