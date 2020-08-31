//
//  MovieService.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation
import Alamofire

struct MovieService: APIService {
    static func movieSearchList(queryString: String, country: String, start: Int, display: Int, completion: @escaping (MovieSearchResult)->Void) {
        let headerParam: HTTPHeaders = ["X-Naver-Client-Id": "unyQtNpHf6QScXy35y2i",
                                        "X-Naver-Client-Secret": "R7X3lD0Qbz"]
        
        let queryParam: [String: Any] = ["query": queryString,
                                        "country": country,
                                        "start": start,
                                        "display" : display]
        
        AF.request(baseUrl(), method: .get, parameters: queryParam, encoding: URLEncoding.default, headers: headerParam).responseJSON {
            response in switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let movieList = try JSONDecoder().decode(MovieSearchResult.self, from: jsonData)
                    completion(movieList)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
