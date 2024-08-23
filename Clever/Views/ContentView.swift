//
//  ContentView.swift
//  Clever

import SwiftUI

struct ContentView: View {
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var selectedTab: Tab = .home
    @State private var createFlashcardDisplayed = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if selectedTab == Tab.home {
                    header
                }
                ZStack(alignment: .top) {
                    TabView(selection: $selectedTab) {
                        if courseViewModel.courses.isEmpty {
                            Text("Tap the ‘+’ to create your first course and start learning!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        } else {
                            CourseListView(courseViewModel: courseViewModel)
                            .padding(.top)
                                .tabItem {
                                    Label("Home", systemImage: "house.fill")
                                }
                                .tag(Tab.home)
                        }
                        Spacer()
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "gear")
                            }
                            .tag(Tab.settings)
                    }
                    .accentColor(.luckypoint)
                    addCourseButton
                }
            }
            .overlay(loadingOverlay)
//            .toolbar() {
//                if selectedTab == Tab.home {
//                    ToolbarItemGroup(placement: .navigationBarTrailing) {
//                        Image(systemName: "person")
//                            .padding(.trailing, 30)
//                    }
//                }
//            }
        }
        .navigationViewStyle(.stack)
    }

    func tabNavigationTitle(for tab: Tab) -> String {
        switch tab {
        case .home:
            return Tab.home.rawValue
        case .settings:
            return Tab.settings.rawValue
        }
    }
}

extension ContentView {
    private var header: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient:
                            Gradient(colors: [.luckypoint.opacity(0.4), .luckypoint]),
                           startPoint: .top,
                           endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 24.0, style: .continuous))
            .edgesIgnoringSafeArea(.all)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ready to learn?")
                        .font(.title)
                        .bold()
                    Text("Choose a course and begin your learning \njourney.")
                        .font(.subheadline)

                }
                Spacer()
            }
            .padding(.top, 10)
            .foregroundStyle(.white)
            .padding(.leading, 30)
        }
        .frame(height: 130)
    }

    private var loadingOverlay: some View {
        Group {
            if courseViewModel.isCreatingCourse {
                ProgressView("Creating Course...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }

    private var addCourseButton: some View {
        VStack {
            Spacer()
            CircularButton(imageName: "plus") {
                createFlashcardDisplayed.toggle()
            }
            .offset(y: -20)
            .sheet(isPresented: $createFlashcardDisplayed){
                CourseCreationView(courseViewModel: courseViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
