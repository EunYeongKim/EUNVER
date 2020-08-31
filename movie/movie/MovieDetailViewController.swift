//
//  MovieDetailViewController.swift
//  movie
//
//  Created by 60080252 on 2020/08/28.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class MovieDetailViewController: UIViewController {
    var movie: Movie = Movie()

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var korMovieTitle: UILabel!
    @IBOutlet weak var engMovieTitle: UILabel!
    @IBOutlet weak var moviePubDate: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    @IBOutlet weak var movieUserRating: UILabel!
    @IBOutlet weak var movieRatingBar: CosmosView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI(with: movie)
    }
    
    func initUI(with movie: Movie) {
        korMovieTitle.sizeToFit()
        engMovieTitle.sizeToFit()
        movieUserRating.sizeToFit()

        guard let tmpKorMovieTitle = movie.movieTitle, let tmpEngMovieTitle = movie.movieSubtitle else { return }
        korMovieTitle.text = tmpKorMovieTitle.htmlEscaped
        engMovieTitle.text = tmpEngMovieTitle.htmlEscaped
        moviePubDate.text = movie.moviePubDate
        guard let movieDirectorStr = movie.movieDirector, let movieActorStr = movie.movieActor else { return }
        movieDirector.text = movieDirectorStr.replacingOccurrences(of: "|", with: " ")
        movieActors.text = movieActorStr.replacingOccurrences(of: "|", with: " ")

        guard let imageUrlStr = movie.movieImage else { return }
        if imageUrlStr.isEmpty {
            movieImage.image = UIImage(named: "defaultImg.png")
        } else {
            let imageUrl = URL(string: imageUrlStr)
            movieImage.kf.setImage(with: imageUrl)
        }

        movieUserRating.text = movie.movieUserRating
        guard let userRatingStr = movie.movieUserRating else { return }
        guard let userRating = Double(userRatingStr) else { return }
        movieRatingBar.rating = userRating / 2
    }
}
