//
//  Thumbnail.swift
//  movie
//
//  Created by 60080252 on 2020/09/02.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var thumbTitle: String
    var thumbLink: String
    var thumbImage: String
    var thumbHeightSize: String
    var thumbWidthSize: String
}

extension Thumbnail {
    enum CodingKeys: String, CodingKey {
        case thumbTitle = "title"
        case thumbLink = "link"
        case thumbImage = "thumbnail"
        case thumbHeightSize = "sizeheight"
        case thumbWidthSize = "sizewidth"
    }
}

struct ThumbnailSearchResult: Codable {
    var lastBuildDate: String?
    var total: Int?
    var start: Int?
    var display: Int?
    var items: [Thumbnail] = []
}
