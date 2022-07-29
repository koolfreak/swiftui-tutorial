//
//  NetworkManager.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 7/29/22.
//
import Network
import Foundation

class NetworkManager: ObservableObject {
    
    let networkMonitor = NWPathMonitor()
    let networkQueue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true
    
    var networkImageStatus: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: networkQueue)
    }
    
}
