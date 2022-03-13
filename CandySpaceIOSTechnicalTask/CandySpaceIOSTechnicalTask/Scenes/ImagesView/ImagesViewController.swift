//
//  ImagesViewController.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation
import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ImagesViewModel?
    
    private let itemsPerRow: CGFloat = 3
    private let itemsSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gallery"
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
}

// TODO: if pagination is implemented, another api call with incremented page should be called if the user scrolls to like 80% from the bottom
// TODO: Also, all pending image request api call should be cancelled if the collection view is being scrolled to prevent redundent API calls
// TODO: The image request api call should be resumed if the collection view stops scrolling
extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.datasource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        if let hit = viewModel?.datasource[row],
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            let viewModel = ImageCollectionViewCellViewModel(hit: hit)
            cell.viewModel = viewModel
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = view.frame.width - itemsSpacing * 2
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
