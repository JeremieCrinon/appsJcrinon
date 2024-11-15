//
//  Api.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import Foundation


func APIWithoutBodyWithoutJWT<T: Decodable>(url: URL, viewModel: ViewModel) async -> T? {
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to fetch or decode API data from \(url):\n\(error)")
        viewModel.error(message: "Internal server error!")
        return nil
    }
}


func APIWithoutBodyWithJWT<T: Decodable>(url: URL, token: String, viewModel: ViewModel) async -> T? {
    // Create a URLRequest and add the JWT to the Authorization header
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    do {
        // Send the request and wait for the response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check if the response is an HTTP URL response and has a valid status code
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            if(httpResponse.statusCode >= 400 && httpResponse.statusCode < 500){
                viewModel.clientError(code: httpResponse.statusCode)
                return nil
            } else {
                print("Server returned an error: \(httpResponse.statusCode)")
                viewModel.error(message: "Internal server error!")
                return nil
            }
        }
        
        // Decode the data
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to fetch or decode API data from \(url):\n\(error)")
        viewModel.error(message: "Internal server error!")
        return nil
    }
}

func APIWithBodyWithoutJWT<T: Decodable, U: Encodable>(url: URL, body: U, viewModel: ViewModel) async -> T? {
    // Create a URLRequest and set the HTTP method and body
    var request = URLRequest(url: url)
    request.httpMethod = "POST"  // or PUT, PATCH depending on the request type
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Encode the body to JSON
    do {
        let jsonData = try JSONEncoder().encode(body)
        request.httpBody = jsonData
    } catch {
        print("Failed to encode body: \(error)")
        viewModel.error(message: "Failed to encode request body")
        return nil
    }

    do {
        // Send the request and wait for the response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check if the response is an HTTP URL response and has a valid status code
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            if httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                viewModel.clientError(code: httpResponse.statusCode)
                return nil
            } else {
                print("Server returned an error: \(httpResponse.statusCode)")
                viewModel.error(message: "Internal server error!")
                return nil
            }
        }
        
        // Decode the data
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to fetch or decode API data from \(url):\n\(error)")
        viewModel.error(message: "Internal server error!")
        return nil
    }
}

func APIWithBodyWithJWT<T: Decodable, U: Encodable>(url: URL, body: U, token: String, viewModel: ViewModel) async -> T? {
    
    // Create a URLRequest and set the HTTP method, headers, and body
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    // Encode the body to JSON
    do {
        let jsonData = try JSONEncoder().encode(body)
        request.httpBody = jsonData
    } catch {
        print("Failed to encode body: \(error)")
        viewModel.error(message: "Failed to encode request body")
        return nil
    }

    do {
        // Send the request and wait for the response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check if the response is an HTTP URL response and has a valid status code
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            if httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                viewModel.clientError(code: httpResponse.statusCode)
                return nil
            } else {
                print("Server returned an error: \(httpResponse.statusCode)")
                viewModel.error(message: "Internal server error!")
                return nil
            }
        }
        
        
        // Decode the data
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to fetch or decode API data from \(url):\n\(error)")
        viewModel.error(message: "Internal server error!")
        return nil
    }
}
