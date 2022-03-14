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
    
    var didLoadingStatusChange: ((Bool) -> ())?
    
    init(hit: Hit, imageRequestRepository: ImageRequestRepository = ImageRequestRepository()) {
        self.hit = hit
        self.imageRequestRepository = imageRequestRepository
    }
    
    func loadImage() {
        didLoadingStatusChange?(true)
        imageRequestRepository.loadImage(urlString: hit.previewURL) { [weak self] source, result in
            guard let weakSelf = self else { return }
            weakSelf.didLoadingStatusChange?(false)
            switch result {
            case .failure(let error):
                weakSelf.didErrorOccur?(error)
                break
            case .success(let data):
                weakSelf.didDataChange?(data)
                break
            }
        }
    }
    
    func cancelImageLoading() {
        imageRequestRepository.cancelImageLoading()
    }
}
