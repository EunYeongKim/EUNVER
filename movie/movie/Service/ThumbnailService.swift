//
//  ThumbnailService.swift
//  movie
//
//  Created by 60080252 on 2020/09/02.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation
import Alamofire

struct ThumbnailService {
    static func thumbnailSearchList(queryString: String, start: Int, display: Int, completion: @escaping (ThumbnailSearchResult)->Void) {
        let headerParam: HTTPHeaders = ["X-Naver-Client-Id": Config.APIKey.naverClientId,
                                        "X-Naver-Client-Secret": Config.APIKey.naverClientKey]
        
        let queryParam: [String: Any] = ["query": queryString,
                                        "start": start,
                                        "display" : display]
        
        AF.request(Config.URL.thumbnailSearchUrl, method: .get, parameters: queryParam, encoding: URLEncoding.default, headers: headerParam).responseJSON {
            response in switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let imageList = try JSONDecoder().decode(ThumbnailSearchResult.self, from: jsonData)
                    completion(imageList)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
