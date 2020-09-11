//
//  ThumbnailCollectionViewCell.swift
//  movie
//
//  Created by 60080252 on 2020/09/02.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit
import Kingfisher

class ThumbnailCollectionViewCell: UICollectionViewCell {
    var thumbData: Thumbnail? {
        didSet {
            guard let thumb = thumbData else { return }
            let imageUrl = URL(string: thumb.thumbImage)

            self.thumbImageView.kf.indicatorType = .activity
            self.thumbImageView.kf.setImage(with: imageUrl)
        }
    }
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        thumbImageView.layer.cornerRadius = 20
        thumbImageView.layer.masksToBounds = true
        thumbImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        thumbImageView.layer.shadowOpacity = 0.6
        thumbImageView.layer.shadowRadius = 5
    }
}
