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
    func fetchCourses(forceRefresh: Bool = false) {
        //1. Return cached data if available and no force refresh is requested
        if !forceRefresh, let cachedCourses = Self.cachedCourses {
            print("[CACHE] Returning cached courses: \(cachedCourses.count)")
            self.courses = cachedCourses
            return
        }

        guard let url = URL(string: baseURL) else {
            self.errorMessage = "Invalid URL."
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(apiKey)", forHTTPHeaderField: "apikey")

        isLoading = true
        errorMessage = nil
        
        print("[API] Fetching courses from API...")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                print("[HTTP] Status Code: \(response.statusCode)")

                guard (200...299).contains(response.statusCode) else {
                    let message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    throw NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                }

                return output.data
            }
            .decode(type: [Course].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false

                switch completion {
                case .finished:
                    print("[DEBUG] Successfully fetched courses.")
                case .failure(let error):
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                    print("[ERROR] \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] courses in
                self?.courses = courses
                
                //2. Cache the result after successful fetch
                Self.cachedCourses = courses
                
                print("[DEBUG] Courses received: \(courses.count)")
            }
            .store(in: &cancellables)
    }
}
