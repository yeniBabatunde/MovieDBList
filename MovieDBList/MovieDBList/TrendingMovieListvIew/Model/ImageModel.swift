//
//  ImageModel.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation

// MARK: - ImageModel
struct ImageModel: Codable {
    var backdrops: [Backdrop]?
    var id: Int?
//    var logos, posters: [Backdrop]?
}

struct Backdrop: Codable {
    var aspectRatio: Double?
    var height: Int?
    var iso639_1: String?
    var filePath: String?
    var voteAverage: Double?
    var voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
