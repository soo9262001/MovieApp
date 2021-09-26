//
//  Resource.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import Foundation

struct R {
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3/movie"
        static let imgURL = "https://image.tmdb.org/t/p/w500"
    }
    
    struct KEYS {
        static let api_key = "0e9447a2d2567ef3bd00018aca6d17a2"
    }
    
    struct CELL {
        static let tableViewCell = "MovieTableViewCell"
        static let detailTableViewCell = "MovieInfoTableViewCell"
        static let mainCellId = "mainCell"
        static let detailCellId = "detailCell"
        static let segueId = "toDetail"
    }
}
