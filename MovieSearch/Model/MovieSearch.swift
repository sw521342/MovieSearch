//
//  MovieSearch.swift
//  MovieSearch
//
//  Created by S W on 8/15/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

struct MovieSearch: Decodable {
    let movies: [Movie]
    let totalResults: String
    let response: String
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
    
    static func forTitle(_ title: String?, completion: @escaping (MovieSearch?) -> Void) {
        guard
            let title = title,
            let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            escapedTitle.count > 2,
            let url = URL(string: "https://www.omdbapi.com/?s=\(escapedTitle)&type=movie&apikey=19f13ee8")
        else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            let movieSearch = try? decoder.decode(MovieSearch.self, from: data)
            
            completion(movieSearch)
        }
        
        task.resume()
    }
}
