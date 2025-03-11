//
//  SocialMediaHomeContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomeContentView: View {
    @State private var stories: [Story] = demoStories  // Use demoStories
    @State private var posts: [SocialMediaPost] = demoPosts  // Use demoPosts
    
    var body: some View {
        VStack {
            SocialMediaHomeHeaderView()
            
            ScrollView {
                VStack {
                    // Pass demo data to SocialMediaHomeStoryView
                    SocialMediaHomeStoryView(stories: stories)
                    
                    // Pass demo data to SocialMediaHomePostView
                    ForEach(posts, id: \.userName) { post in
                        SocialMediaHomePostView(post: post)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: "F8F9FA"))
        }
    }
}

#Preview {
    SocialMediaHomeContentView()
}
