//
//  ContentView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 25.06.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var courseViewModel = CourseViewModel()
    

    @State private var selectedTab: Tab = .home
    @State private var presentImporter = false
    @State private var createFlashcardDisplayed = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if selectedTab == Tab.home {
                    HStack(alignment: .center) {
                        homeHeader
                            .padding()
                        Image("home2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(CGSize(width: -15, height: 10))

                    }

                }
                ZStack(alignment: .top) {
                    TabView(selection: $selectedTab) {
                        CourseListView(courseViewModel: courseViewModel)
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                            .tag(Tab.home)
                        
                        Spacer()
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "gear")
                            }
                            .tag(Tab.settings)
                    }
                    .accentColor(Color("Purple Text"))

                    addCourseButton
                }
            }
            .overlay(loadingOverlay)
            .toolbar() {
                if selectedTab == Tab.home {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        welcomeUserHeader
                    }
                }
            }
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
    
    private var homeHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ready to learn?")
                .font(.largeTitle)
                .bold()
            Text("Choose a course and begin your learning \njourney.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.leading)
        .padding(.top, 10)
    }
    
    private var welcomeUserHeader: some View {
        HStack {
            Spacer()
            HStack {
                VStack(alignment: .trailing) {
                    Text("Welcome,")
                        .bold()
                    Text("Leo!")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .foregroundColor(.black)
                
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 35))
                    .foregroundStyle(Color("Purple Primary"))
//                    .foregroundColor(Color("Purple Text"))
            }
        }
        .padding(.vertical, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
