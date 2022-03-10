//
//  ContentView.swift
//  HanlinChen-NYCSchools
//
//  Created by Hanlin Chen on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var schoolViewModel = SchoolViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            if schoolViewModel.schools.count == 0 {
                ProgressView().progressViewStyle(CircularProgressViewStyle()).navigationTitle("NYC Schools")
            }
            else {
                List {
                    ForEach(searchResult){
                        school in
                        NavigationLink(destination: {
                                
                            if let satScore = schoolViewModel.getSATScoreById(id: school.id){
                                SchoolDetailView(name: school.schoolName, latitude: Double(school.latitude), longitude:Double(school.longitude), avgMathScore: satScore.avgMathScore,avgWritingScore: satScore.avgWritingScore, avgReadingScore: satScore.avgReadingScore, numberOfTester: satScore.numberOfTestTakers)
                            }else{
                            SchoolDetailView(name: school.schoolName, latitude: Double(school.latitude), longitude:Double(school.longitude), avgMathScore: 0,avgWritingScore: 0, avgReadingScore: 0, numberOfTester: 0)
                            }
                            
                            
                        },
                                       label: {
                            SchoolListItemView(schoolName: school.schoolName, studentNumber: school.totalStudents, graduationRate: school.graduationRate)
                        })
                   
                    }
                }.refreshable {
                    Task {
                        await schoolViewModel.fetchSchools()
                    }
                }  .searchable(text: $searchText).navigationTitle("NYC Schools").navigationBarItems(trailing: Button(action: {
                    schoolViewModel.sortSchoolsByStudentNumber()
                    
                }, label: {
                    Image(systemName: "arrow.up.arrow.down")
                }))
            }
        }
    }
    
    var searchResult:[School] {
        if searchText.isEmpty {
            return schoolViewModel.schools
        }
        else{
            return schoolViewModel.schools.filter { $0.schoolName.contains(searchText)}
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
