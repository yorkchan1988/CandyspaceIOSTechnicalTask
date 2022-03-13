//
//  ImagesViewModel.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import Foundation

class ImagesViewModel: ViewModel {
    
    let datasource: [Hit]
    
    init(datasource: [Hit]) {
        self.datasource = datasource
    }
}
