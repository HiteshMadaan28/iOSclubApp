//
//  SocialMediaHomeModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 11/03/25.
//

import Foundation
import SwiftUICore

struct SocialMediaPost {
    var userName: String
    var postDate: String
    var content: String
    var likes: Int
    var comments: Int
    var shares: Int
    var profileImage: String
    var postImage: String
}

struct Story {
    var userName: String
    var backgroundColor: Color
}

// MARK :- DataSet
let demoPosts: [SocialMediaPost] = [
    SocialMediaPost(
        userName: "Sally",
        postDate: "Mar 28, 2025",
        content: "Had an amazing trip to the mountains this weekend! #Adventure #Nature",
        likes: 120,
        comments: 25,
        shares: 18,
        profileImage: "SallyProfileImage",  // Replace with actual image name
        postImage: "SallyPostImage"         // Replace with actual image name
    ),
    SocialMediaPost(
        userName: "Jason",
        postDate: "Feb 18, 2025",
        content: "Finally finished the marathon! Proud moment. #MarathonFinisher #HardWorkPaysOff",
        likes: 450,
        comments: 80,
        shares: 35,
        profileImage: "JasonProfileImage", // Replace with actual image name
        postImage: "JasonPostImage"        // Replace with actual image name
    ),
    SocialMediaPost(
        userName: "Jena",
        postDate: "Jan 12, 2025",
        content: "Loving the new book I started reading. Highly recommend it! #Bookworm #Reading",
        likes: 95,
        comments: 40,
        shares: 10,
        profileImage: "JenaProfileImage",  // Replace with actual image name
        postImage: "JenaPostImage"         // Replace with actual image name
    )
]

// Sample demo data for Story
let demoStories: [Story] = [
    Story(userName: "You", backgroundColor: Color.gray),
    Story(userName: "Sally", backgroundColor: Color.red),
    Story(userName: "Jason", backgroundColor: Color.blue),
    Story(userName: "Jena", backgroundColor: Color.green),
    Story(userName: "Michale", backgroundColor: Color.yellow),
    Story(userName: "Lary", backgroundColor: Color.pink)
]
