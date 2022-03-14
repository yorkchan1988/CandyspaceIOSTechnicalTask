//
//  SearchViewModel.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation

class SearchViewModel: ViewModel {
    
    let searchRepository: SearchRepository
    
    var didLoadingStatusChange: ((Bool) -> ())?
    
    init(searchRepository: SearchRepository = SearchRepository()) {
        self.searchRepository = searchRepository
    }
    
    func searchPhotos(searchText: String) {
        didLoadingStatusChange?(true)
        searchRepository.searchPhotos(searchText: searchText) { [unowned self] source, result in
            didLoadingStatusChange?(false)
            switch result {
            case .failure(let error):
                self.didErrorOccur?(error)
                break
            case .success(let data):
                self.didDataChange?(data)
                break
            }
        }
    }
}
