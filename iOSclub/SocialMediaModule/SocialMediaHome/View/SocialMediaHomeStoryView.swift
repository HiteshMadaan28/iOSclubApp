//
//  SocialMediaHomeStoryView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomeStoryView: View {
    var stories: [Story]  // Accept the stories data
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                
                VStack(spacing: 0){
                    Image("StorySelector")
                        .frame(width: 44)
                        .padding(.top, 18)
                        .padding(.bottom, 10)
                    
                    Text("You")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex: "#323842"))
                        .padding(.bottom, 18)
                }
                
                
                ForEach(stories, id: \.userName) { story in
                    VStack(spacing: 0) {
                        Circle()
                            .fill(story.backgroundColor.opacity(0.4))
                            .frame(width: 44)
                            .padding(.top, 18)
                            .padding(.bottom, 10)
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text(story.userName)
                                .font(.custom("Inter", size: 14))
                                .foregroundStyle(Color(hex: "#323842"))
                                .padding(.bottom, 18)
                        }
                    }
                    .padding(.leading, 18)
                }
            }
            .padding(.leading, 18)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SocialMediaHomeStoryView(stories: [
        Story(userName: "Sally", backgroundColor: .red),
        Story(userName: "Jason", backgroundColor: .blue),
        Story(userName: "Jena", backgroundColor: .green),
        Story(userName: "Michale", backgroundColor: .yellow),
        Story(userName: "Lary", backgroundColor: .pink),
        Story(userName: "Sally", backgroundColor: .red)
    ])
}
