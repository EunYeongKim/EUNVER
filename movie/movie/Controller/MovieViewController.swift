//
//  MovieViewController.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    private let country: String = ""
    private var queryString: String = ""
    private let displayCount: Int = 100
    private var itemStartIdx: Int = 0
    private var movies: MovieSearchResult = MovieSearchResult()
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.prefetchDataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? MovieTableViewCell {
            guard let indexPath = movieTableView.indexPath(for: cell) else { return }
            if let vc = segue.destination as? MovieDetailViewController {
                vc.movie = self.movies.items[indexPath.row]
            }
        }
    }
    
    // SearchBar로 검색 시
    func loadMovies(queryString: String) {
        self.itemStartIdx = 0
        MovieService.movieSearchList(queryString: queryString, country: self.country, start: 1, display: self.displayCount) { result in
            self.movies = result
            self.movieTableView.setContentOffset(.zero, animated: true)
            if let movieDisplay = self.movies.display {
                self.itemStartIdx += movieDisplay
            }
            self.movieTableView.reloadData()
        }
    }
    
    // pagination 처리 - 추가 결과를 보여줌
    func loadMoreMovies() {
        guard movies.items.count - 1 < self.itemStartIdx else { return }
        MovieService.movieSearchList(queryString: queryString, country: self.country, start: self.itemStartIdx + 1, display: self.displayCount) { result in
            self.movies.items.append(contentsOf: result.items)
            if let movieDisplay = self.movies.display {
                self.itemStartIdx += movieDisplay
            }
            self.movieTableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == self.itemStartIdx - 1 {
                loadMoreMovies()
                break
            }
        }
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if self.queryString.isEmpty {
            movies = MovieSearchResult()
            movieTableView.reloadData()
        } else {
            loadMovies(queryString: self.queryString)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let queryString = searchBar.text else { return }
        self.queryString = queryString
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        let currentCellMovie = self.movies.items[indexPath.row]
        cell.movieData = currentCellMovie
        
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
