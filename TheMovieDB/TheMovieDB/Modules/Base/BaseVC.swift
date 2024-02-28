//
//  BaseVC.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import UIKit

class BaseVC: UIViewController {
    
    // Globals
    var transparentNavbar = false
    var loadingDialog: LoadingDialogVC?
    
    // Views
    lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var globalContentView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var scrollViewContent: UIStackView = {
        let scrollViewContent = UIStackView(frame: .zero)
        scrollViewContent.axis = .vertical
        scrollViewContent.spacing = 10
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        return scrollViewContent
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.transparentNavbar {
            let appearance = self.createNavbarAppereance(.transparent)
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.transparentNavbar {
            let appearance = self.createNavbarAppereance(.dark)
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.transparentNavbar = false
        }
    }
    
    func setNavigationBar(title: String?) {
        if self.navigationController != nil {
            let appearance = self.createNavbarAppereance(.dark)
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = title
            
            let backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateBack(sender:)))
            self.navigationItem.backBarButtonItem = backBarButtonItem
        }
    }
    
    func setTransparentNavbar() {
        self.transparentNavbar = true
    }
    
    func configureContentView() {
        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureScrollableContentView() {
        self.view.addSubview(globalContentView)
        globalContentView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.addArrangedSubview(contentView)
        
        
        // POSITIONS
        NSLayoutConstraint.activate([
            globalContentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            globalContentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            globalContentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            globalContentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: globalContentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: globalContentView.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: globalContentView.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: globalContentView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor)
        ])
    }
    
    func showLoadingDialog(message: String? = nil) {
        loadingDialog = LoadingDialogVC()
        loadingDialog?.dialogText = message ?? Constants.Common.loadingLabel
        loadingDialog?.modalPresentationStyle = .overFullScreen
        loadingDialog?.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            self.present(self.loadingDialog!, animated: true, completion: nil)
        }
    }
    
    func hideLoadingDialog(completion: (() -> Void)?) {
        guard let loadingDialog = loadingDialog else { return }
        loadingDialog.dismissDialog(completion: completion)
    }
    
    func showAlert(title: String, message: String, accept: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.Common.acceptButton, style: .default) { (action:UIAlertAction) in
            (accept ?? {})()
        }
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func navigateBack(sender: Any?) {
        if let navigator = self.navigationController {
            navigator.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func createNavbarAppereance(_ background: NavbarBackground) -> UINavigationBarAppearance {
        // Navbar apperance
        let appearance = UINavigationBarAppearance()
        
        switch background {
        case .dark:
            appearance.backgroundColor = .dark
        default:
            appearance.configureWithTransparentBackground()
        }
        
        appearance.shadowColor = .clear // Removes bottom shadow line
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }

}

enum NavbarBackground {
    case dark
    case transparent
}


// MARK: -  View Controllers Preview

import SwiftUI
struct GenericViewControllerPreview: UIViewControllerRepresentable {
    private let onViewControllerSet: () -> BaseVC

    init(_ viewControllerToBuild: @escaping(() -> BaseVC)) {
        self.onViewControllerSet = viewControllerToBuild
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = onViewControllerSet()
        return UINavigationController(rootViewController: viewController)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}
