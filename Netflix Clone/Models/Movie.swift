//
//  Movie.swift
//  Netflix Clone
//
//  Created by diayan siat on 26/02/2022.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let page: Int?
    let results: [T]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movies: Codable {
    let id: Int?
    let name: String?
    let backdropPath: String?
    let firstAirDate: String?
    let genreIDS: [Int]?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let popularity: Double?
    let mediaType: String?
    let originalTitle, releaseDate: String?
    let video: Bool?
    let title: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video, title, adult
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ko = "ko"
    case tr = "tr"
}



