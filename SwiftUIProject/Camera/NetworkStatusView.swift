//
//  NetworkStatusView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 7/29/22.
//

import SwiftUI

struct NetworkStatusView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        ZStack {
            
            Color(.systemBlue).ignoresSafeArea()
            VStack {
                Image(systemName: networkManager.networkImageStatus)
                    .resizable().scaledToFit()
                    .frame(width: 200, height: 200).foregroundColor(.white)
            }
            
        }
    }
}

struct NetworkStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkStatusView()
    }
}
