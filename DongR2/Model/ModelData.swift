//
//  ModelData.swift
//  DongR2
//
//  Created by wopark on 2021/01/06.
//

import Foundation
import Combine

//var clubs: [Club] = load("clubData.json")
final class ModelData: ObservableObject {
    @Published var clubs: [Club] = load("clubData.json")
    
    var categories: [String: [Club]] {
        Dictionary(
            grouping: clubs,
            by: { $0.category.rawValue }
        )
    }
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
