//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by S W on 8/15/18.
//  Copyright © 2018 S W. All rights reserved.
//

import UIKit

struct MovieDetail: Decodable {
    let metascore: String
    let plot: String
    
    private enum CodingKeys: String, CodingKey {
        case metascore = "Metascore"
        case plot = "Plot"
    }
}
