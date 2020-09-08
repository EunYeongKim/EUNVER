//
//  Config.swift
//  movie
//
//  Created by 60080252 on 2020/08/31.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation
import UIKit

struct Config {
    static let baseUrl = "https://openapi.naver.com/v1/search"
    struct URL {
        static let movieSearchUrl = baseUrl + "/movie.json"
        static let thumbnailSearchUrl = baseUrl + "/image"
    }
    struct APIKey {
        static let naverClientId = "unyQtNpHf6QScXy35y2i"
        static let naverClientKey = "R7X3lD0Qbz"
    }
    enum Font{
        enum AppleSDGothicNeo: String {
            case Regular = "AppleSDGothicNeo-Regular"
            
            func of(_ size: CGFloat) -> UIFont {
                return UIFont(name: self.rawValue, size: size) ?? UIFont()
            }
        }
    }
}
