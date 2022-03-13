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
    
    func goToImagesView() {
        let imagesView = ImagesViewController(nibName: "ImagesViewController", bundle: nil)
        view?.navigationController?.pushViewController(imagesView, animated: true)
    }
}
