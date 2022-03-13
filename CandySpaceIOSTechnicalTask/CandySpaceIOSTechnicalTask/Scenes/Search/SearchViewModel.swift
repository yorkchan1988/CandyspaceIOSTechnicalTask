//
//  SearchViewModel.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation

class SearchViewModel: ViewModel {
    
    let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository = SearchRepository()) {
        self.searchRepository = searchRepository
    }
    
    func searchPhotos(searchText: String) {
        searchRepository.searchPhotos(searchText: searchText) { [unowned self] source, result in
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
