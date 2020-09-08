//
//  MovieTableViewCell.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    var movieData: Movie? {
        didSet {
            guard let movie = movieData else { return }
            if let tmpKorMovieTitle = movie.movieTitle {
                self.korMovieTitle.attributedText = tmpKorMovieTitle.htmlEscapedWithHighlight(isTitle: true, colorHex: "#a0b4fa", font: Config.Font.AppleSDGothicNeo.Regular.of(15))
            }
            if let tmpEngMovieTitle = movie.movieSubtitle {
                self.engMovieTitle.attributedText = tmpEngMovieTitle.htmlEscapedWithHighlight(isTitle: false, colorHex: "#a0b4fa", font: Config.Font.AppleSDGothicNeo.Regular.of(15))
            }

            self.movieImage.kf.indicatorType = .activity
            // 이미지URL이 없을 경우 default이미지로 대체
            guard let imageUrlStr = movie.movieImage else { return }
            if imageUrlStr.isEmpty {
                self.movieImage.image = UIImage(named: "defaultImg.png")
            } else {
                let imageUrl = URL(string: imageUrlStr)
                self.movieImage.kf.setImage(with: imageUrl)
            }
        }
    }

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var korMovieTitle: UILabel!
    @IBOutlet weak var engMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        korMovieTitle.sizeToFit()
        engMovieTitle.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
