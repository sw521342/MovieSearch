//
//  Movie.swift
//  MovieSearch
//
//  Created by S W on 8/14/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    let title: String
    let posterURL: URL
    let imdbID: String
    
    private var detailURL: URL {
        return URL(string: "https://www.omdbapi.com/?i=\(imdbID)&apikey=19f13ee8")!
    }
    
    func loadDetail(completion: @escaping (MovieDetail?) -> Void) {
        let task = URLSession.shared.dataTask(with: detailURL) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            let movieDetail = try? decoder.decode(MovieDetail.self, from: data)
            completion(movieDetail)
        }
        
        task.resume()
    }
    
    func loadPosterImage(completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: posterURL) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        
        task.resume()
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case posterURL = "Poster"
        case imdbID
    }
}
