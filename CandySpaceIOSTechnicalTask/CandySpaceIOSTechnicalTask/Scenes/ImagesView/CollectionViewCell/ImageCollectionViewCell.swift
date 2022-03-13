//
//  ImageCollectionViewCell.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var isLoading: Bool = false {
        didSet {
            imageView.isHidden = isLoading
            loadingView.isHidden = !isLoading
            loadingView.startAnimating()
        }
    }
    
    var viewModel: ImageCollectionViewCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.didDataChange = { [weak self] data in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading = false
                    if let data = data as? Data, let image = UIImage(data: data) {
                        weakSelf.imageView.image = image
                    }
                }
                viewModel.didErrorOccur = { [weak self] error in
                    guard let weakSelf = self else { return }
                    weakSelf.isLoading = false
                }
                isLoading = true
                viewModel.loadImage()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    deinit {
        viewModel?.cancelImageLoading()
    }
}
