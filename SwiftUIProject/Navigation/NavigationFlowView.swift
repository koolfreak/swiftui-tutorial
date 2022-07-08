//
//  NavigationFlowView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 6/18/22.
// https://github.com/tunds/YouTubeResources
// source: https://www.youtube.com/watch?v=Jr0rU8TGzjs

import SwiftUI

struct NavigationFlowView: View {
    
    @StateObject private var settingNavManager = SettingNavigationManager()
    
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house")  }
            
            SettingsView().environmentObject(settingNavManager)
                .tabItem { Label("Settings", systemImage: "gearshape")}
            
        }
    }
}

struct HomeView: View {
    
    @State private var shouldShowDetails: Bool = false
    @State private var shouldShowDocument: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mint
                VStack {
                    Text("Home Screen")
                    NavigationLink("Goto to a screen", destination: Text("Welcome to screen #1")).foregroundStyle(.white)
                    NavigationLink(destination: Text("Welcome to profile screen")) {
                        Image(systemName: "person")
                            .symbolVariant(.fill.circle)
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                    Group {
                        Button("Trigger detail push"){
                            shouldShowDetails.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        NavigationLink("Go to details", isActive: $shouldShowDetails) {
                            Text("Details Preview")
                        }
                    }
                    
                    Group {
                        Button("Trigger document push"){
                            shouldShowDocument.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        NavigationLink( isActive: $shouldShowDocument) {
                            DocumentDetailsView(showDocumentsDetail: $shouldShowDocument)
                        }label: {
                            Image(systemName: "doc")
                                .symbolVariant(.fill.circle)
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Home")
        }
    }
}


final class SettingNavigationManager: ObservableObject {
    
    @Published var screen: Screens? {
        didSet {
            
        }
    }
    
    func push(to screen: Screens){
        self.screen = screen
    }
    
    func popToRoot(){
        screen = nil
    }
}

enum Screens {
    case marketingOptions
    case submitMarketingOptions
    case appVersion
}

extension Screens: Hashable {}

struct MarketingOptionView: View {
    var body: some View {
        VStack {
            Text("Marketing Options Screens")
            NavigationLink("Go to submit marketing options screen", destination: SubmitMarketingOptionView())
        }
    }
}

struct AppVersionView: View {
    var body: some View {
        VStack {
            Text("App Version Screens")
        }
    }
}

struct SubmitMarketingOptionView: View {
    
    @EnvironmentObject var settingNavManager: SettingNavigationManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Submit Marketing Options Screens")
            Button("Go to root") {
                settingNavManager.popToRoot()
            }
            Button("Go to previous screen") {
                dismiss()
            }
        }
    }
}

struct SettingsView: View {
    
    @EnvironmentObject var settingNavManager: SettingNavigationManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pink
                VStack {
                    Text("Settings Screen")
                    Button("Go to marketing options screen"){
                        settingNavManager.push(to: .marketingOptions)
                    }
                    .background(
                        NavigationLink(tag: .marketingOptions,
                                       selection: $settingNavManager.screen,
                                       destination: {
                                           MarketingOptionView()
                                       },
                                       label: { EmptyView() })
                    )
                    //
                    Button("Go to submit marketing options screen"){
                        settingNavManager.push(to: .submitMarketingOptions)
                    }
                    .background(
                        NavigationLink(tag: .submitMarketingOptions,
                                       selection: $settingNavManager.screen,
                                       destination: {
                                           SubmitMarketingOptionView()
                                       },
                                       label: { EmptyView() })
                    )
                    //
                    Button("Go to app version screen"){
                        settingNavManager.push(to: .appVersion)
                    }
                    .background(
                        NavigationLink(tag: .appVersion,
                                       selection: $settingNavManager.screen,
                                       destination: {
                                           AppVersionView()
                                       },
                                       label: { EmptyView() })
                    )
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AppVersionView(), tag: .appVersion, selection: $settingNavManager.screen){
                        Image(systemName: "mail.stack").symbolVariant(.fill)
                    }
                }
                //
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AppVersionView(), tag: .marketingOptions, selection: $settingNavManager.screen){
                        Image(systemName: "doc.plaintext").symbolVariant(.fill)
                    }
                    NavigationLink(destination: AppVersionView(), tag: .submitMarketingOptions, selection: $settingNavManager.screen){
                        Image(systemName: "paperplane").symbolVariant(.fill)
                    }
                }
                
            }
        }
    }
}


struct NavigationFlowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFlowView() //.environmentObject(SettingNavigationManager())
    }
}
