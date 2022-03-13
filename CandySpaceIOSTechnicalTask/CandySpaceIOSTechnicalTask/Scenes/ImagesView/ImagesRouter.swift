//
//  ImagesRouter.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation

class ImagesRouter {
    
    weak var view: ImagesViewController?
    
    init(view: ImagesViewController) {
        self.view = view
    }
    
    func back() {
        view?.navigationController?.popViewController(animated: true)
    }
}
