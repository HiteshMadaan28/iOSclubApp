//
//  JobContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 05/04/25.
//

import SwiftUI

struct JobContentView: View {
    @StateObject var viewModel = JobViewModel()
    @GestureState private var dragOffset = CGSize.zero
    @State private var selectedTab: JobTab = .all

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Menu
                HStack {
                    Spacer()
                    ForEach(JobTab.allCases, id: \.self) { tab in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = tab
                            }
                        }) {
                            Text(tab.rawValue)
                                .font(.system(size: 20, weight: selectedTab == tab ? .bold : .regular))
                                .foregroundColor(selectedTab == tab ? .black : .gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    Capsule()
                                        .fill(selectedTab == tab ? Color.gray.opacity(0.2) : Color.clear)
                                )
                        }
                        Spacer()
                    }
                }
                .padding(.top, 50)
                .padding(.bottom, 12)

                Divider()

                Spacer()

                // Card Stack View
                if selectedTab == .all {
                    ZStack {
                        if viewModel.jobs.isEmpty {
                            Text("No more jobs 🎉")
                                .font(.title3)
                                .foregroundColor(.gray)
                        } else {
                            ForEach(Array(viewModel.jobs.enumerated().reversed()), id: \.element.id) { index, job in
                                if index >= viewModel.currentIndex {
                                    JobCardView(job: job)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding(32)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(radius: 8)
                                        .offset(x: offset(for: index),
                                                y: index == viewModel.currentIndex ? dragOffset.height : CGFloat(index - viewModel.currentIndex))
                                        .scaleEffect(index == viewModel.currentIndex ? 1.0 : 0.95)
                                        .zIndex(Double(viewModel.jobs.count - index))
                                        .gesture(index == viewModel.currentIndex ?
                                            DragGesture()
                                                .updating($dragOffset) { value, state, _ in
                                                    state = value.translation
                                                }
                                                .onEnded { value in
                                                    handleSwipe(value: value)
                                                } : nil
                                        )
                                        .animation(.spring(), value: dragOffset)
                                        .animation(.spring(), value: viewModel.currentIndex)
                                }
                            }
                        }
                    }
                }

                // Saved Tab View
                if selectedTab == .saved {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            if viewModel.savedJobs.isEmpty {
                                Text("You haven’t saved any jobs yet.")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .padding(.top, 40)
                            } else {
                                ForEach(viewModel.savedJobs, id: \.id) { job in
                                    JobCardView(job: job)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }

                Spacer()

                // Bottom Swipe Hints (Optional - you can remove this if you want cleaner UI)
                if selectedTab == .all && !viewModel.jobs.isEmpty {
                    HStack(spacing: 40) {
                        VStack {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text("Skip")
                                .font(.caption)
                        }

                        VStack {
                            Image(systemName: "bookmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Save")
                                .font(.caption)
                        }

                        VStack {
                            Image(systemName: "heart.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            Text("Interested")
                                .font(.caption)
                        }
                    }
                    .padding(.bottom, 40)
                    .transition(.move(edge: .bottom))
                }
            }

            // Toast View
            if let toast = viewModel.toastMessage {
                ToastView(message: toast)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
            }
        }
    }

    func offset(for index: Int) -> CGFloat {
        return index == viewModel.currentIndex ? dragOffset.width : 0
    }

    func handleSwipe(value: DragGesture.Value) {
        let horizontal = value.translation.width
        let vertical = value.translation.height

        if abs(horizontal) > 100 {
            if horizontal > 0 {
                viewModel.showToast(message: "Interested ❤️")
                viewModel.moveToPreviousJob()
            } else {
                viewModel.showToast(message: "Skipped ❌")
                viewModel.moveToNextJob()
            }
        } else if vertical < -100 {
            viewModel.saveCurrentJob()
            viewModel.moveToNextJob()
        }
    }
}




struct JobCardView: View {
    var job: Job

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(job.title)
                        .font(.title2)
                        .bold()
                    Text(job.company)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                Spacer()
                Image(systemName: "briefcase.fill")
                    .foregroundColor(.blue)
            }

            Text(job.location)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()

            Text(job.description)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    JobContentView()
}



