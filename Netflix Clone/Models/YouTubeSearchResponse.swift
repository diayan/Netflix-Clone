//
//  YouTubeSearchResponse.swift
//  Netflix Clone
//
//  Created by diayan siat on 28/02/2022.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: VideoId
}

struct VideoId: Codable {
    let kind: String
    let videoId: String
}
