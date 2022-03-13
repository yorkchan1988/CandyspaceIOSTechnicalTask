//
//  AlertView.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation
import UIKit

struct AlertView {
    
    static func showErrorAlert(error: Error, target: UIViewController?) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        target?.present(alert, animated: true)
    }
    
    static func showAlert(title: String, message: String, target: UIViewController?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        target?.present(alert, animated: true)
    }
}
