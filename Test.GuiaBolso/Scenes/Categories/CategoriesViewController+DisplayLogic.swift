//
//  CategoriesViewController+DisplayLogic.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol CategoriesDisplayLogic: class {
    func displayLoadingState()
    func displayDynamicData()
    func displayResponseError(message errorMessage: String)
    func displayRandomJoke()
}

extension CategoriesViewController: CategoriesDisplayLogic {
    
    func displayLoadingState() {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = Colors.main
        activityIndicatorView.hidesWhenStopped = true
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    
    func displayDynamicData() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func displayResponseError(message errorMessage: String) {
        let alert = UIAlertController(
            title: R.string.categories.error_title(),
            message: R.string.categories.error_message(),
            preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: R.string.categories.error_button(), style: .default) { _ in
            self.requestCategories()
        }
        alert.addAction(reloadAction)
        present(alert, animated: true)
    }
    
    func displayRandomJoke() {
        router?.routeToJoke()
    }
    
}
