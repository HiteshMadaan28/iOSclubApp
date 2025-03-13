//
//  CourseDetailView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 13/03/25.
//

import SwiftUI

struct CourseDetailView: View {
    // MARK: - Properties
    var course: Course
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Course Image
                AsyncImage(url: URL(string: course.image_url)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 250)
                .cornerRadius(12)
                
                // Course Title
                Text(course.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#111517"))
                
                // Course Content
                Text(course.content)
                    .font(.body)
                    .foregroundColor(Color(hex: "#647987"))
                    .padding(.top, 8)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(course.title, displayMode: .inline)
        }
    }
}
