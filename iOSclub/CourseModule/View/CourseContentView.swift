//
//  CourseModuleContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI

import SwiftUI

struct CourseContentView: View {
    // MARK: - Properties
    @ObservedObject var viewModel = CoursesViewModel()

    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer().frame(width: 48) // Placeholder for alignment
                    Text("Courses")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#111517"))
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        // Search button action
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "#111517"))
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .background(Color.white)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "#647987"))
                        .padding(.leading, 8)
                        .background(Color(hex: "#f0f3f4"))
                    TextField("Search courses", text: .constant(""))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color(hex: "#f0f3f4"))
                        .cornerRadius(8)
                        .foregroundColor(Color(hex: "#111517"))
                }
                .background(Color(hex: "#f0f3f4"))
                .cornerRadius(12)
                .padding(.horizontal,16)

                // Course Cards
                ScrollView {
                    VStack(spacing: 0) {
                        // Display Courses Dynamically
                        ForEach(viewModel.courses) { course in
                            NavigationLink(destination: CourseDetailView(course: course)) {
                                Course_Card(imageURL: course.image_url, title: course.title, description: course.short_description)
                            }
                        }
                        
                        // Show Loading Spinner if Data is Being Fetched
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }

                        // Show Error Message if Any
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                viewModel.fetchCourses()
            }
        }
    }
}


struct Course_Card: View {
    var imageURL: String
    var title: String
    var description: String

    var body: some View {
        VStack(alignment:.leading,spacing:0){
            // Course Image
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 200)
            .cornerRadius(8)

            // Course Title and Description
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "#111517"))
                .padding(.top, 16)

            Text(description)
                .font(.subheadline)
                .foregroundColor(Color(hex: "#647987"))
                .padding(.top, 4)
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding(16)
    }
}


#Preview(body: {
    CourseContentView()
})
