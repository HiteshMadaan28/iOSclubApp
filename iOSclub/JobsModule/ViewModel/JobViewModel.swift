//
//  JobViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 05/04/25.
//

import Foundation

class JobViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var jobs: [Job] = []
    @Published var currentIndex: Int = 0
    @Published var savedJobs: [Job] = []
    @Published var skippedJobs: [Job] = []
    @Published var appliedJobs: [Job] = []
    @Published var toastMessage: String? = nil

    // MARK: - Initialization
    init() {
        loadJobs()
    }

    // MARK: - Job Actions
    func skipCurrentJob() {
        guard currentIndex < jobs.count else { return }
        skippedJobs.append(jobs[currentIndex])
        showToast(message: "Skipped ❌")
        removeCurrentJob()
    }

    func applyToCurrentJob() {
        guard currentIndex < jobs.count else { return }
        appliedJobs.append(jobs[currentIndex])
        showToast(message: "Applied 📨")
        removeCurrentJob()
    }

    func saveCurrentJob() {
        guard currentIndex < jobs.count else { return }
        var job = jobs[currentIndex]
        job.isSaved = true
        savedJobs.append(job)
        showToast(message: "Saved Job 💾")
        removeCurrentJob()
    }

    func moveToNextJob() {
        guard currentIndex < jobs.count else { return }
        removeCurrentJob()
    }

    func moveToPreviousJob() {
        guard currentIndex < jobs.count else { return }
        removeCurrentJob()
    }

    private func removeCurrentJob() {
        jobs.remove(at: currentIndex)
        // No need to change currentIndex since next job slides into this index
    }

    // MARK: - Toast Helper
    func showToast(message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.toastMessage = nil
        }
    }

    // MARK: - Load Jobs
    func loadJobs() {
        jobs = [
            Job(title: "iOS Developer", company: "Apple", location: "Cupertino, CA", description: "Build innovative iOS apps for global users."),
            Job(title: "SwiftUI Engineer", company: "Spotify", location: "Remote", description: "Build beautiful and performant UI in SwiftUI."),
            Job(title: "Junior iOS Developer", company: "StartupX", location: "New York, NY", description: "Join a fast-paced startup and grow your skills."),
            Job(title: "Mobile Software Engineer", company: "Netflix", location: "Los Gatos, CA", description: "Help shape the future of entertainment."),
            Job(title: "iOS Architect", company: "Google", location: "Mountain View, CA", description: "Lead architecture for large-scale mobile apps."),
            Job(title: "React Native/iOS Developer", company: "Facebook", location: "Menlo Park, CA", description: "Work on cross-platform mobile experiences."),
            Job(title: "Xcode Plugin Engineer", company: "JetBrains", location: "Remote", description: "Enhance developer tooling for Apple platforms."),
            Job(title: "ARKit Developer", company: "Snap Inc.", location: "Los Angeles, CA", description: "Build AR experiences with cutting-edge tech."),
            Job(title: "iOS Intern", company: "Zomato", location: "Gurgaon, India", description: "Kickstart your iOS dev career with real-world projects."),
            Job(title: "Senior Swift Engineer", company: "Revolut", location: "London, UK", description: "Lead Swift-based projects and mentor juniors.")
        ]
    }
}
