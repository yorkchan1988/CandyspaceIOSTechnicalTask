//
//  ViewModel.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class ViewModel {
    var didDataChange: ((Any) -> ())?
    var didErrorOccur: ((NetworkError) -> ())?
}
