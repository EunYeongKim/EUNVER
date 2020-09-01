//
//  MovieService.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation
import Alamofire

struct MovieService {
    static func movieSearchList(queryString: String, country: String, start: Int, display: Int, completion: @escaping (MovieSearchResult)->Void) {
        let headerParam: HTTPHeaders = ["X-Naver-Client-Id": Config.APIKey.naverClientId,
                                        "X-Naver-Client-Secret": Config.APIKey.naverClientKey]
        
        let queryParam: [String: Any] = ["query": queryString,
                                        "country": country,
                                        "start": start,
                                        "display" : display]
        
        AF.request(Config.URL.movieSearchBaseUrl, method: .get, parameters: queryParam, encoding: URLEncoding.default, headers: headerParam).responseJSON {
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
