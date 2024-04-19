//
//  SpotifyModels.swift
//  Moody_iOS
//
//  Created by Paula Basswerner on 4/19/24.
//

import Foundation

struct RecommendationResponse: Codable {
    let tracks: [Track]
}

struct Track: Codable {
    let name: String
    let id: String
    let album: Album
    let artists: [Artist]
    let previewUrl: URL?
}

struct Album: Codable {
    let name: String
    let images: [SpotifyImage]
}

struct Artist: Codable {
    let name: String
    let id: String
}

struct SpotifyImage: Codable {
    let url: URL
    let height: Int?
    let width: Int?
}
