//
//  CoursesModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 13/03/25.
//

import Foundation

struct Course: Identifiable, Codable {
    let id: Int
    let image_url: String
    let title: String
    let short_description: String
    let content: String
    let created_at: String

    enum CodingKeys: String, CodingKey {
        case id
        case image_url = "image_url"
        case title
        case short_description = "short_description"
        case content
        case created_at = "created_at"
    }
}
