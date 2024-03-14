//
//  MainView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/9.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    // Search text and filter variables
    @State private var searchText: String = ""
    @State private var selectedCategory: CourseCategory? = nil
    @State private var isShowingCategorySheet: Bool = false
    @State private var priceFilter: Double = 0.0
    @State private var isShowingPriceFilter: Bool = false
    
    var body: some View {
        VStack {
            // Search and filter controls
            HStack {
                TextField("Search by Name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    isShowingCategorySheet = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.system(size: 22))
                }
                .padding(.trailing, 10)
                .actionSheet(isPresented: $isShowingCategorySheet) {
                    ActionSheet(title: Text("Select Category"), buttons: getActionSheetButtons())
                }
                
                Button(action: {
                    isShowingPriceFilter = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 22))
                }
                .padding(.trailing, 10)
                .actionSheet(isPresented: $isShowingPriceFilter) {
                    ActionSheet(title: Text("Filter by Price"), buttons: getPriceFilterActionSheetButtons())
                }
            }
            
            // List of filtered courses
            List {
                if filteredCourses.isEmpty {
                    Text("No matching courses available at the moment, please try later.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(filteredCourses) { course in
                        NavigationLink(destination: DetailView(course: course).environmentObject(fireDBHelper)) {
                            HStack {
                                if let imageName = course.courseImageName {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                } else {
                                    Image("default")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                }
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(course.courseName)
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Text("Category: \(course.courseCategories.rawValue)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Price: $\(String(format: "%.2f", course.coursePrice))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Enrollment: \(course.studentGrades.count) (\(course.studentLimit))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle()) // Remove default list style
        }
        .padding()
        .navigationBarTitle("Courses")
    }
    
    // Computed property to filter courses based on search text, category, and price
    private var filteredCourses: [Course] {
        fireDBHelper.courseList.filter { course in
            let isMatchingSearchText = searchText.isEmpty || course.courseName.localizedCaseInsensitiveContains(searchText)
            let isMatchingCategory = selectedCategory == nil || course.courseCategories == selectedCategory!
            let isMatchingPrice = course.coursePrice >= priceFilter
            return isMatchingSearchText && isMatchingCategory && isMatchingPrice
        }
    }
    
    // Get ActionSheet buttons for selecting categories
    private func getActionSheetButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        buttons.append(.default(Text("All Categories")) {
            selectedCategory = nil
        })
        for category in CourseCategory.allCases {
            buttons.append(.default(Text(category.rawValue.capitalized)) {
                selectedCategory = category
            })
        }
        buttons.append(.cancel())
        return buttons
    }
    
    // Get ActionSheet buttons for filtering prices
    private func getPriceFilterActionSheetButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        for price in [0.0, 5.0, 10.0, 15.0, 20.0, 25.0] {
            buttons.append(.default(Text("$\(String(format: "%.2f", price))")) {
                priceFilter = price
            })
        }
        buttons.append(.cancel())
        return buttons
    }
}

