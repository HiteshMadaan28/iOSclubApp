//
//  CoursesViewModel.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 13/03/25.
//

import Foundation
import Combine

class CoursesViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Cache
    private static var cachedCourses: [Course]? // Static to share cache across instances
    private var hasFetchedOnce: Bool {
        return Self.cachedCourses != nil
    }

    // MARK: - Constants
    private let baseURL = "https://jgjldpbanbvqmjzcndit.supabase.co/rest/v1/courses"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnamxkcGJhbmJ2cW1qemNuZGl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTg3NjEsImV4cCI6MjA1NDk5NDc2MX0.tLZ_9mQUOxeZAPuSLPml3lR3CNsOm_yDkGmN2y9rSME"
    
    // MARK: - Public API
    
    /// Fetches courses, returns cache if available (unless forced).
    func fetchCourses(forceRefresh: Bool = false) async {
        await withCheckedContinuation { continuation in
            // Check if we should use cached courses
            if !forceRefresh, let cachedCourses = Self.cachedCourses {
                self.courses = cachedCourses
                continuation.resume()
                return
            }

            guard let url = URL(string: baseURL) else {
                self.errorMessage = "Invalid URL."
                continuation.resume()
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("\(apiKey)", forHTTPHeaderField: "apikey")

            isLoading = true
            errorMessage = nil
            print("[API] Fetching courses from API...")

            // Perform network request
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else {
                    continuation.resume()
                    return
                }

                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                    continuation.resume()
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid server response."
                    self.isLoading = false
                    continuation.resume()
                    return
                }

                print("[HTTP] Status Code: \(httpResponse.statusCode)")

                guard (200...299).contains(httpResponse.statusCode) else {
                    let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    self.errorMessage = "Error: \(message)"
                    self.isLoading = false
                    continuation.resume()
                    return
                }

                // Decode data
                guard let data = data else {
                    self.errorMessage = "No data received."
                    self.isLoading = false
                    continuation.resume()
                    return
                }

                do {
                    let courses = try JSONDecoder().decode([Course].self, from: data)
                    self.courses = courses
                    Self.cachedCourses = courses
                    self.isLoading = false
                    print("[DEBUG] Courses received: \(courses.count)")
                } catch {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                }

                continuation.resume()
            }.resume()
        }
    }

}
