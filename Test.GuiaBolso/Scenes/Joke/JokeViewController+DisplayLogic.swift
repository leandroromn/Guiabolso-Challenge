//
//  JokeViewController+DisplayLogic.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 28/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SafariServices

protocol JokeDisplayLogic: class {
    func displayView(title viewTitle: String)
    func displayLoadingState()
    func displayFilledState()
    func displayRandomJoke(viewModel: Joke.ViewModel)
    func displayResponseError(message errorMessage: String)
    func displayJokePageBy(url jokeUrl: String)
}

extension JokeViewController: JokeDisplayLogic {
    
    func displayView(title viewTitle: String) {
        title = viewTitle.capitalized
    }
    
    func displayLoadingState() {
        reproduceAnimation { self.contentView.alpha = 0.0 }
        activityIndicator.color = Colors.main
        activityIndicator.startAnimating()
    }
    
    func displayFilledState() {
        activityIndicator.stopAnimating()
    }
    
    func displayRandomJoke(viewModel: Joke.ViewModel) {
        reproduceAnimation {
            self.contentView.alpha = 1.0
            self.avatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.avatarImageView.sd_setImage(with: URL(string: viewModel.iconImageUrl))
            self.jokePhraseLabel.text = viewModel.phrase
        }
    }
    
    private func reproduceAnimation(contentAction: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            contentAction()
        }
    }
    
    func displayResponseError(message errorMessage: String) {
        let alert = UIAlertController(
            title: R.string.joke.error_title(),
            message: R.string.joke.error_message(),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: R.string.joke.error_button(), style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    func displayJokePageBy(url jokeUrl: String) {
        guard let url = URL(string: jokeUrl) else { return }
        present(SFSafariViewController(url: url), animated: true)
    }
    
}
