//
//  Movie.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation

struct Moive: Codable {
    var movieTitle: String?
    var movieLink: String?
    var movieImage: String?
    var movieSubtitle: String?
    var moviePubDate: String?
    var movieDirector: String?
    var movieActor: String?
    var movieUserRating: String?
}

extension Moive {
    enum CodingKeys: String, CodingKey {
        case movieTitle = "title"
        case movieLink = "link"
        case movieImage = "image"
        case movieSubtitle = "subtitle"
        case moviePubDate = "pubDate"
        case movieDirector = "director"
        case movieActor = "actor"
        case movieUserRating = "userRating"
    }
}

struct MovieSearchResult: Codable {
    var lastBuildDate: String?
    var total: Int?
    var start: Int?
    var display: Int?
    var items: [Moive] = []
}
