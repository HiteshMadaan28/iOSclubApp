//
//  SocialMediaHomePostView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomePostView: View {
    var post: SocialMediaPost  // Accept the post data
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    // Profile image
                    Circle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: 38)
                        .padding(.top, 18)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // User name
                        Text(post.userName)
                            .font(.custom("Inter", size: 12).bold())
                            .padding(.leading, 12)
                        
                        HStack(spacing: 0) {
                            // Post date
                            Text(post.postDate)
                                .font(.custom("Inter", size: 11).bold())
                                .foregroundStyle(Color(hex: "#9095A0"))
                                .padding(.leading, 12)
                            
                            Circle()
                                .fill(Color(hex: "#BCC1CA"))
                                .frame(width: 4)
                                .padding(.leading, 9)
                                .padding([.top, .bottom], 7)
                            
                            Image("EarthIcon")
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.top, 18)
                    
                    Spacer()
                    
                    // Dotted menu
                    Image("DotedMenu")
                        .padding([.trailing, .top], 32)
                }
                .padding(.leading, 24)
                
                // Post content
                Text(post.content)
                    .font(.custom("Inter", size: 14))
                    .foregroundStyle(Color(hex:"#171A1F"))
                    .padding([.top, .bottom], 18)
                    .padding(.trailing, 24)
                    .padding(.leading, 24)
                
                // Action buttons (like, comment, share)
                HStack(spacing: 0) {
                    Image("ThumbsUp")
                        .padding(.leading, 24)
                        .padding([.top, .bottom], 23)
                    
                    Text("\(post.likes)")
                        .padding(.leading, 10)
                        .foregroundStyle(Color(hex:"#636AE8"))
                    
                    Image("CommentIcon")
                        .padding(.leading, 29)
                    
                    Text("\(post.comments)")
                        .padding(.leading, 10)
                        .foregroundStyle(Color(hex:"#9095A0"))
                    
                    Spacer()
                    
                    Image("ShareIcon")
                        .padding(.leading, 29)
                    
                    Text("\(post.shares)")
                        .padding(.leading, 10)
                        .foregroundStyle(Color(hex:"#9095A0"))
                        .padding(.trailing, 22)
                }
            }
            .background(Color.white)
        }
        .padding(.bottom, 11)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SocialMediaHomePostView(post: SocialMediaPost(
        userName: "Sally",
        postDate: "Mar 28, 2022",
        content: "It was great catching up with my bestie",
        likes: 20,
        comments: 3,
        shares: 1,
        profileImage: "ProfileImage", // This can be an image name or URL
        postImage: "PostImage" // Optional image for the post, if needed
    ))
}
