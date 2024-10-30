//
//  ModelData.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import Foundation

// Load local JSON synchronously as before
var pages: [Page] = loadJson("Pages.json")

var configs: [Config] = loadJson("Config.json")
var config = configs[0]



func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
