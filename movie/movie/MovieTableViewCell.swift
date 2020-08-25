//
//  MovieTableViewCell.swift
//  movie
//
//  Created by 60080252 on 2020/08/25.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

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
