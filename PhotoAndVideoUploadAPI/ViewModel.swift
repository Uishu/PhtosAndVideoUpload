//
//  ViewModel.swift
//  PhotoAndVideoUploadAPI
//
//  Created by Disha on 10/07/24.
//
import Foundation
import UIKit

func uploadMedia(file: Any, fileType: String) {
    let urlString = "https://comsedt.com"
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var body = Data()
    
    // Add Google ID
    let googleId = "123445676543"
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"google_id\"\r\n\r\n".data(using: .utf8)!)
    body.append("\(googleId)\r\n".data(using: .utf8)!)
    
    // Add File Type
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"fileType\"\r\n\r\n".data(using: .utf8)!)
    body.append("\(fileType)\r\n".data(using: .utf8)!)
    
    // Add File
    let fileName: String
    let mimeType: String
    let fileData: Data
    
    if fileType == "Photos", let image = file as? UIImage, let imageData = image.jpegData(compressionQuality: 0.8) {
        fileName = "photo.jpg"
        mimeType = "image/jpeg"
        fileData = imageData
    } else if fileType == "Videos", let videoUrl = file as? URL {
        fileName = "video.mov"
        mimeType = "video/quicktime"
        fileData = try! Data(contentsOf: videoUrl)
    } else {
        return
    }
    
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
    body.append(fileData)
    body.append("\r\n".data(using: .utf8)!)
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    request.httpBody = body
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(jsonResponse)
                // Handle the response here
            }
        } catch {
            print("Error parsing response: \(error.localizedDescription)")
        }
    }
    
    task.resume()
}
