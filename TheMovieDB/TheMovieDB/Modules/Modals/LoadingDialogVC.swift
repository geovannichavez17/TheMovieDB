//
//  LoadingDialogVC.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import UIKit

class LoadingDialogVC: UIViewController {
    
    var dialogText: String?
        
        lazy var contentStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 12
            return stack
        }()
        
        lazy var contentLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = dialogText ?? Constants.Common.loadingLabel
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = .boldSystemFont(ofSize: 16)
            return label
        }()
        
        lazy var activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.style = .large
            indicator.color = .white
            indicator.startAnimating()
            return indicator
        }()
        
        var blurEffectView: UIVisualEffectView = {
            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurEffectView.alpha = 0.2
            blurEffectView.autoresizingMask = [
                .flexibleWidth, .flexibleHeight
            ]
            
            return blurEffectView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.renderModal()
        }
        
        func renderModal() {
            
            view.backgroundColor = .semiTransparentBlack
            blurEffectView.frame = self.view.bounds
            
            contentStack.addArrangedSubview(activityIndicator)
            contentStack.addArrangedSubview(contentLabel)
            view.addSubview(contentStack)
            view.insertSubview(blurEffectView, at: 0)
            
            NSLayoutConstraint.activate([
                contentStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                contentStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                contentStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
                contentStack.heightAnchor.constraint(equalToConstant: 70)
            ])
            NSLayoutConstraint.activate([
                contentLabel.heightAnchor.constraint(equalToConstant: 22)
            ])
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        func dismissDialog(completion: (() -> Void)?) {
            self.dismiss(animated: true, completion: {
                OperationQueue.main.addOperation {
                    (completion ?? {})()
                }
            })
        }
}
