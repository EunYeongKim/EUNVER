//
//  ImageViewController.swift
//  movie
//
//  Created by 60080252 on 2020/09/02.
//  Copyright © 2020 60080252. All rights reserved.
//

import UIKit

class ThumbnailViewController: UIViewController {
    private var loadMoreFlag: Bool = false
    private var queryString: String = ""
    private let displayCount: Int = 100
    private var itemStartIdx: Int = 0
    var thumbnailResult: ThumbnailSearchResult = ThumbnailSearchResult()
    
    @IBOutlet weak var thumbCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbCollectionView.prefetchDataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func loadThumbs(queryString: String) {
        if !self.loadMoreFlag {
            self.itemStartIdx = 0
            ThumbnailService.thumbnailSearchList(queryString: queryString, start: 1, display: self.displayCount) { result in
                self.thumbnailResult = result
                self.thumbCollectionView.setContentOffset(.zero, animated: true)
                if let thumbDisplay = self.thumbnailResult.display {
                    self.itemStartIdx += thumbDisplay
                }
                self.thumbCollectionView.reloadData()
                self.loadMoreFlag = true
            }
        } else {
            guard thumbnailResult.items.count - 1 < self.itemStartIdx else { return }
            ThumbnailService.thumbnailSearchList(queryString: self.queryString, start: self.itemStartIdx + 1, display: self.displayCount) { result in
                self.thumbnailResult.items.append(contentsOf: result.items)
                if let thumbDisplay = self.thumbnailResult.display {
                    self.itemStartIdx += thumbDisplay
                }
                self.thumbCollectionView.reloadData()
            }
        }
    }
}

extension ThumbnailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == self.itemStartIdx - 1 {
                loadThumbs(queryString: self.queryString)
                break;
            }
        }
    }
}

extension ThumbnailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if self.queryString.isEmpty {
            self.thumbnailResult = ThumbnailSearchResult()
            self.thumbCollectionView.reloadData()
        } else {
            self.loadMoreFlag = false
            loadThumbs(queryString: queryString)
        }
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
        
        let currentCell = self.thumbnailResult.items[indexPath.item]
        cell.thumbData = currentCell
        
        return cell
    }
}

extension ThumbnailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        let bounds = thumbCollectionView.bounds
        
        var width = bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
        var height = bounds.height - (layout.sectionInset.top + layout.sectionInset.bottom)
        
        width = (width - (layout.minimumInteritemSpacing * 1)) / 2
        height = (height - (layout.minimumLineSpacing * 3)) / 4
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
}

