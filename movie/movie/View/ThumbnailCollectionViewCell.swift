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
}
