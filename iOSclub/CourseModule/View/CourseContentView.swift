//
//  CourseModuleContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI


struct CourseContentView: View {
    // MARK: - Properties
    @ObservedObject var viewModel = CoursesViewModel()
    @State private var searchText: String = ""

    // MARK: - Body
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Text("Courses")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#111517"))
                        .frame(maxWidth: .infinity)
                    Spacer()
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
                    TextField("Search courses", text: $searchText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color(hex: "#f0f3f4"))
                        .cornerRadius(8)
                        .foregroundColor(Color(hex: "#111517"))
                }
                .background(Color(hex: "#f0f3f4"))
                .cornerRadius(12)
                .padding(.horizontal, 16)

                // Course Cards List with Pull-to-Refresh
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Filtered Courses if search text is active
                        ForEach(filteredCourses(), id: \.id) { course in
                            NavigationLink(destination: CourseDetailView(course: course)) {
                                Course_Card(
                                    imageURL: course.image_url,
                                    title: course.title,
                                    description: course.short_description
                                )
                            }
                        }

                        // Loading spinner
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }

                        // Error message display
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding(.top, 8)
                }
                .refreshable {
                    print("Manual refresh triggered!")
                    viewModel.fetchCourses(forceRefresh: true)
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                print("OnAppear triggered!")
                viewModel.fetchCourses(forceRefresh: false)
            }
        }
    }

    // MARK: - Filtered Courses based on search text
    private func filteredCourses() -> [Course] {
        if searchText.isEmpty {
            return viewModel.courses
        } else {
            return viewModel.courses.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.short_description.localizedCaseInsensitiveContains(searchText)
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
