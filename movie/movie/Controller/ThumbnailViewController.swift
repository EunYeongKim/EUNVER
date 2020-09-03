//
//  ImageViewController.swift
//  movie
//
//  Created by 60080252 on 2020/09/02.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit
import Kingfisher

class ThumbnailViewController: UIViewController {
    private var queryString: String = ""
    private let displayCount: Int = 100
    private var itemStartIdx: Int = 0
    var thumbnailResult: ThumbnailSearchResult = ThumbnailSearchResult()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var thumbCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbCollectionView.prefetchDataSource = self
    }
    
    func loadThumbs(queryString: String) {
        self.itemStartIdx = 0
        ThumbnailService.thumbnailSearchList(queryString: queryString, start: 1, display: self.displayCount) { result in
            self.thumbnailResult = result
            self.thumbCollectionView.setContentOffset(.zero, animated: true)
            if let thumbDisplay = self.thumbnailResult.display {
                self.itemStartIdx += thumbDisplay
            }
            self.thumbCollectionView.reloadData()
        }
    }
    
    func loadMoreThumbs() {
        guard thumbnailResult.items.count - 1 < self.itemStartIdx else { return }
        ThumbnailService.thumbnailSearchList(queryString: self.queryString, start: self.itemStartIdx, display: self.displayCount) { result in
            self.thumbnailResult.items.append(contentsOf: result.items)
            if let thumbDisplay = self.thumbnailResult.display {
                self.itemStartIdx += thumbDisplay
            }
            self.thumbCollectionView.reloadData()
        }
    }
}

extension ThumbnailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == self.itemStartIdx - 1 {
                loadMoreThumbs()
                break;
            }
        }
    }
}

extension ThumbnailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let queryString = searchBar.text else { return }
        loadThumbs(queryString: queryString)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let queryString = searchBar.text else { return }
        self.queryString = queryString
    }
}

extension ThumbnailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailResult.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = thumbCollectionView.dequeueReusableCell(withReuseIdentifier: "thumbCell", for: indexPath) as! ThumbnailCollectionViewCell
    
        let currentCell = self.thumbnailResult.items[indexPath.row]
        cell.thumbData = currentCell
        
        return cell
    }
}

extension ThumbnailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}

