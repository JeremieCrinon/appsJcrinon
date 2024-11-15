//
//  ViewModel+Projects.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 01/11/2024.
//

import Foundation
import SwiftUI
import UIKit // For image verifications

extension ViewModel {
    func getProjects() async -> Void { // This function is called by the verifyConnexion() of ViewModel+Login
        
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
//                self.errorMessage = "There has been an error getting the token in the keychain."
                self.disconnect()
            }
            return
        }
        
        let url = URL(string: "\(config.apiBaseUrl)/api/projects/get")!
        
        if let response: [Project] = await APIWithoutBodyWithJWT(url: url, token: token, viewModel: self){
            DispatchQueue.main.async {
                self.projects = response
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the projects list."
            }
            return
        }
        
        if(self.clientErrorCode != nil) { // In case the server returned a client error
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the projects list."
            }
            return
        }
        
    }
    
    func createProject(name: String, description: String, french_name: String, french_description: String, github_link: String?, project_link: String?, image: Data?) async -> String?{
        
//        DispatchQueue.main.async {
//            self.isLoading = true
//        }
        
        // Verifications
        if name.isEmpty || description.isEmpty || french_name.isEmpty || french_description.isEmpty {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please fill all required fields"
        }
        
        if image == nil {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please enter an image"
        }
        
        // Verify image is not nil and check dimensions
        guard let imageData = image, let uiImage = UIImage(data: imageData) else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please enter a valid image"
        }
        
        // Verify the image format
            let allowedFormats = ["image/png", "image/jpeg", "image/webp", "image/jpg"]
            if let imageFormat = getImageMimeType(from: imageData), !allowedFormats.contains(imageFormat) {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return "Unsupported image format. Allowed formats are PNG, JPEG, JPG, and WebP."
            }
        
        // Check image width and aspect ratio
        let imageWidth = uiImage.size.width
        let imageHeight = uiImage.size.height
        
        if imageWidth < 768 {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "The image width should be at least 768px"
        }
        
        if imageWidth / imageHeight != 16 / 9 {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "The image should be in 16:9 format"
        }
        
        // Sending request
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
                self.disconnect()
                self.isLoading = false
            }
            return "Error getting the token, try reconnecting" // This message should never be seen cause the error page should be displayed, but in case the error page displays, it is good having an error message
        }
        
        let url = URL(string: "\(config.apiBaseUrl)/api/projects/new")!
        
        // Create boundary for multipart form data
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Prepare the multipart form body
        let body = createMultipartFormBody(
            boundary: boundary,
            name: name,
            french_name: french_name,
            description: description,
            french_description: french_description,
            github_link: github_link,
            project_link: project_link,
            image: image!
        )
        
        request.httpBody = body
        
        
        // Send the request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                self.errorMessage = "Failed to create project, please try restarting the app."
            }
        } catch {
            self.isLoading = false
            print("Line 116")
            self.errorMessage = "Failed to create project, please try restarting the app."
        }
        
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        return nil
    }
}


private func createMultipartFormBody(
    boundary: String,
    name: String,
    french_name: String,
    description: String,
    french_description: String,
    github_link: String?,
    project_link: String?,
    image: Data
) -> Data {
    var body = Data()
    
    let lineBreak = "\r\n"
    let boundaryPrefix = "--\(boundary)\r\n"
    
    // Add text fields
    func appendTextField(_ fieldName: String, _ value: String) {
        body.append(Data(boundaryPrefix.utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".utf8))
        body.append(Data("\(value)\r\n".utf8))
    }
    
    appendTextField("name", name)
    appendTextField("french_name", french_name)
    appendTextField("description", description)
    appendTextField("french_description", french_description)
    
    if let githubLink = github_link {
        appendTextField("github_link", githubLink)
    }
    if let projectLink = project_link {
        appendTextField("project_link", projectLink)
    }
    
    // Add image field
    body.append(Data(boundaryPrefix.utf8))
    body.append(Data("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".utf8))
    body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
    body.append(image)
    body.append(Data(lineBreak.utf8))
    
    // End of multipart form
    body.append(Data("--\(boundary)--\r\n".utf8))
    
    return body
}

func getImageMimeType(from data: Data) -> String? {
    var buffer = [UInt8](repeating: 0, count: 1)
    data.copyBytes(to: &buffer, count: 1)
    
    switch buffer[0] {
    case 0xFF:
        return "image/jpeg"
    case 0x89:
        return "image/png"
    case 0x52 where data.count >= 12:
        let subdata = data.subdata(in: 0..<12)
        if let string = String(data: subdata, encoding: .ascii), string.hasPrefix("RIFF") {
            return "image/webp"
        }
    case 0x47:
        return "image/gif"
    default:
        return nil
    }
    
    return nil
}
