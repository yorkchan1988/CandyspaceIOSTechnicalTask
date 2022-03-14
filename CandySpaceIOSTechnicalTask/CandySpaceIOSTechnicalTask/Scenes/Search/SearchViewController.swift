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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial state
        loadingView.isHidden = true
        
        // bind the viewModel
        viewModel?.didDataChange = { [unowned self] data in
            if let searchResults = data as? SearchResults {
                router?.goToImagesView(searchResults: searchResults)
            }
        }
        viewModel?.didLoadingStatusChange = { [unowned self] isLoading in
            btnSearch.isHidden = isLoading
            loadingView.isHidden = !isLoading
            loadingView.startAnimating()
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

