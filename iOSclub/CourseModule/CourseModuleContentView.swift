//
//  CourseModuleContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 26/01/25.
//

import SwiftUI

struct CourseModuleContentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    CourseModuleContentView()
//}
 
struct CoursesView: View {
    var body: some View {
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
                VStack(spacing: 16) {
                    Course_Card(imageURL: "https://cdn.usegalileo.ai/sdxl10/8b7bddfa-7815-4b48-8533-e00d205d1c21.png", title: "iOS 15 and Swift 5", description: "Master the latest version of iOS and Swift.")
                    Course_Card(imageURL: "https://cdn.usegalileo.ai/sdxl10/b49cf6db-9476-4cab-923d-d443b5ee535b.png", title: "SwiftUI: The Complete Developer Course", description: "Learn how to build and deploy an app with SwiftUI.")
                    Course_Card(imageURL: "https://cdn.usegalileo.ai/sdxl10/b6a01d8f-7ea9-493d-b95b-eedbfdfff2ca.png", title: "The Ultimate Guide to Core Data", description: "Learn everything you need to know about Core Data.")
                    Course_Card(imageURL: "https://cdn.usegalileo.ai/sdxl10/b5656a63-a752-444f-9458-d1cfbb0098dd.png", title: "Algorithms & Data Structures in Swift", description: "Get ready for your next coding interview or assessment.")
                }
                .padding(16)
            }
            
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Course_Card: View {
    let imageURL: String
    let title: String
    let description: String

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
            } placeholder: {
                Color.gray
                    .frame(width: 100, height: 100)
            }
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#111517"))
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#647987"))
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
