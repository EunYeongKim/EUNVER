//
//  MovieViewController.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    private let country: String = ""
    private var queryString: String?
    private var itemStartNum: Int = 1
    private var movies: MovieSearchResult = MovieSearchResult()
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // SearchBar로 검색 시
    func loadMovies(queryValue: String?, country: String) {
        if let queryString = queryValue {
            MovieService.getMovieSearchList(queryString: queryString, country: country, start: 1) { result in
                if let movieResult = result {
                    if movieResult.total != 0 {
                        self.movies = movieResult
                        self.movieTableView.reloadData()
                        if let displayNum = self.movies.display {
                            self.itemStartNum = 1 + displayNum
                        }
                        self.queryString = queryString
                    } else {
                        self.movies = MovieSearchResult()
                        self.movieTableView.reloadData()
                    }
                }
            }
        }
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        loadMovies(queryValue: searchBar.text, country: self.country)
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        
        let currentCellMovie = movies.items[indexPath.row]
        
        let font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)!
        if let tmpKorMovieTitle = currentCellMovie.movieTitle {
            cell.korMovieTitle.attributedText = tmpKorMovieTitle.htmlEscaped(isTitle: true, colorHex: "#a0b4fa", font: font)
        }
        if let tmpEngMovieTitle = currentCellMovie.movieSubtitle {
            cell.engMovieTitle.attributedText = tmpEngMovieTitle.htmlEscaped(isTitle: false, colorHex: "#a0b4fa", font: font)
        }
        
        // 이미지URL이 없을 경우 default이미지로 대체
        if currentCellMovie.movieImage != "" {
            if let imageUrlStr = currentCellMovie.movieImage {
                let imageUrl = URL(string: imageUrlStr)
                cell.movieImage.kf.setImage(with: imageUrl)
            }
        } else {
            cell.movieImage.image = UIImage(named: "defaultImg.png")
        }
        
        return cell
    }
    
    //셀의 높이변경
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell? {
            print(cell.korMovieTitle?.text)
        }
    }
}

extension String {
    // <b> 하이라이트 효과
    func htmlEscaped(isTitle: Bool, colorHex: String, font: UIFont) -> NSAttributedString {
        let titleStyle = """
                    <style>
                    body {
                      font-size: 17px;
                      font-family: \(font.familyName);
                      font-weight: bolder;
                    }
                    b {
                      color: \(colorHex);
                    }
                    </style>
        """
        
        let subtitleStyle = """
                    <style>
                    body {
                      font-family: \(font.familyName);
                      font-size: 13px;
                    }
                    b {
                      color: \(colorHex);
                    }
                    </style>
        """
        var modified = ""
        if isTitle {
            modified = String(format:"\(titleStyle)%@", self)
        } else {
            modified = String(format:"\(subtitleStyle)%@", self)
        }
        
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
}

