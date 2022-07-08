//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 11/1/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var showCamera = false
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Button("Camera") {
                        showCamera.toggle()
                    }
                    NavigationLink(isActive: $showCamera, destination: {
                        CameraUIView()
                    }, label: {
                        EmptyView()
                    })

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
