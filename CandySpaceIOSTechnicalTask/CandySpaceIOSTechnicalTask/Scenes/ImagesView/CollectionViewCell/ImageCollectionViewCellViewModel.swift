//
//  ImageCollectionViewCellViewModel.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class ImageCollectionViewCellViewModel: ViewModel {
    
    private let hit: Hit
    private let imageRequestRepository: ImageRequestRepository
    private var isLargeImageLoaded = false
    
    init(hit: Hit, imageRequestRepository: ImageRequestRepository = ImageRequestRepository()) {
        self.hit = hit
        self.imageRequestRepository = imageRequestRepository
    }
    
    func loadImage() {
        imageRequestRepository.loadImage(urlString: hit.previewURL) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .failure(_):
                break
            case .success(let data):
                if !weakSelf.isLargeImageLoaded {
                    weakSelf.didDataChange?(data)
                }
                break
            }
        }
        imageRequestRepository.loadImage(urlString: hit.largeImageURL) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .failure(_):
                break
            case .success(let data):
                weakSelf.isLargeImageLoaded = true
                weakSelf.didDataChange?(data)
                break
            }
        }
    }
    
    func cancelImageLoading() {
        imageRequestRepository.cancelImageLoading()
    }
}
