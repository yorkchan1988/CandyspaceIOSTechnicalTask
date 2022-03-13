//
//  SearchViewController.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tfSearch: UITextField!
    
    var viewModel: SearchViewModel?
    var router: SearchRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.didDataChange = { [unowned self] data in
            if let searchResults = data as? SearchResults {
                router?.goToImagesView(searchResults: searchResults)
            }
        }
        viewModel?.didErrorOccur = { [unowned self] error in
            AlertView.showErrorAlert(error: error, target: self)
        }
    }
    
    @IBAction func didSearchButtonPress(_ sender: Any) {
        if let text = tfSearch.text, !text.isEmpty {
            viewModel?.searchPhotos(searchText: text)
        }
    }
}

