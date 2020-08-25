//
//  APIService.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation

protocol APIService {
    
}

extension APIService {
    static func baseUrl() -> String {
        return "https://openapi.naver.com/v1/search/movie.json"
    }
}
