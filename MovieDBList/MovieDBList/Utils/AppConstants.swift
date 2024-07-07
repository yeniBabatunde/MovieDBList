//
//  AppConstants.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation

enum AppConstants {
    
    static let API_KEY = "b9fd3c0c458976b0ccced6820b43e561"
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
    
   
    struct Endpoint {
        static let GET_ALL_TRENDING_LIST = "\(BASE_URL)/trending/all/day"
  
        static func GET_IMAGE_BY_MOVIE_TYPE_ND_ID(type: String, id: Int) -> String {
            "\(BASE_URL)\(type)/\(id)/images?"
        }
    } 
}
