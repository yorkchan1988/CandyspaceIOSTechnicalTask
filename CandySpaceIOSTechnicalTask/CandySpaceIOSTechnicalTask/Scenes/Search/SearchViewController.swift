//
//  SearchViewController.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var btnSearch: UIButton!
    
    var viewModel: SearchViewModel?
    var router: SearchRouter?
    var isSearching: Bool = false {
        didSet {
            btnSearch.isHidden = isSearching
            loadingView.isHidden = !isSearching
            loadingView.startAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial state
        isSearching = false
        
        // bind the viewModel
        viewModel?.didDataChange = { [unowned self] data in
            isSearching = false
            if let searchResults = data as? SearchResults {
                router?.goToImagesView(searchResults: searchResults)
            }
        }
        viewModel?.didErrorOccur = { [unowned self] error in
            isSearching = false
            AlertView.showErrorAlert(error: error, target: self)
        }
    }
    
    @IBAction func didSearchButtonPress(_ sender: Any) {
        if let text = tfSearch.text, !text.isEmpty {
            isSearching = true
            viewModel?.searchPhotos(searchText: text)
        }
    }
}

