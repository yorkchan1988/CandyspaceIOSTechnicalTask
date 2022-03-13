//
//  SearchRouter.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation

class SearchRouter {
    
    weak var view: SearchViewController?
    
    init(view: SearchViewController) {
        self.view = view
    }
    
    func goToImagesView(searchResults: SearchResults) {
        let imagesView = ImagesViewController(nibName: "ImagesViewController", bundle: nil)
        let viewModel = ImagesViewModel(datasource: searchResults.hits)
        let router = ImagesRouter(view: imagesView)
        imagesView.viewModel = viewModel
        imagesView.router = router
        view?.navigationController?.pushViewController(imagesView, animated: true)
    }
}
