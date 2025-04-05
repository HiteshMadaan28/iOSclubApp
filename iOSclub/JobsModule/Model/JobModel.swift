//
//  JobModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 05/04/25.
//

import Foundation

enum JobTab: String, CaseIterable {
    case all = "All Jobs"
    case saved = "Saved"
}

struct Job: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let company: String
    let location: String
    let description: String
    var isSaved: Bool = false
}
