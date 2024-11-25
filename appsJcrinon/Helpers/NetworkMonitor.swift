//
//  NetworkMonitor.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 24/11/2024.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    var isConnected: Bool = false

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
