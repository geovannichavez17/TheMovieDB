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
    
    // Views
    var contentView : UIView!
    var loadingDialog: LoadingDialogVC?
    
    
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
    
    func setNavigationBar(title: String?, customRight: NavbarActionModel?) {
        
        if self.navigationController != nil {
            // Navigation bar text colors
            let appearance = self.createNavbarAppereance(.dark)
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.tintColor = .white
            
            // Sets title
            self.navigationItem.title = title
            
            // Setting default back button title
            let backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateBack(sender:)))
            self.navigationItem.backBarButtonItem = backBarButtonItem
            
            if customRight != nil {
                let rightButtonItem = UIBarButtonItem(image: UIImage(named: customRight!.iconName!), style: .plain, target: self, action: customRight?.action)
                self.navigationItem.rightBarButtonItem = rightButtonItem
            }
        }
    }
    
    func setTransparentNavbar() {
        self.transparentNavbar = true
    }
    
    func configureContentView() {

        // Content view
        contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        
        // Handle dismiss keyboard on touch
        let tap = UITapGestureRecognizer(target: contentView, action: #selector(contentView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tap)
        
        // ADDING
        self.view.addSubview(contentView)
        
        
        // POSITIONS
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureScrollableContentView() {
       
        // Content view
        let globalContentView = UIView.init(frame: .zero)
        globalContentView.clipsToBounds = true
        globalContentView.translatesAutoresizingMaskIntoConstraints = false
        globalContentView.isUserInteractionEnabled = true
        
        // * * *  A D D I N G  * * *
        self.view.addSubview(globalContentView)
        
        
        // * * *  P O S I T I O N S  * * *
        NSLayoutConstraint.activate([
            globalContentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            globalContentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            globalContentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            globalContentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // * * *  S C R O L L A B L E   C O N T E N T * * *
        
        // DEFINITIONS
        let scrollView = UIScrollView.init()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Scroll content container
        let scrollViewContent = UIStackView()
        scrollViewContent.axis = .vertical
        scrollViewContent.spacing = 10
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        // Content container view
        contentView = UIView.init()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        
        // ADDING
        
        // Adding scroll to view
        globalContentView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        // Adding content
        scrollViewContent.addArrangedSubview(contentView)
        
        
        // POSITIONS
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
            // this is important for scrolling
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor)
        ])
        
        // Handle dismiss keyboard on touch
        let tap = UITapGestureRecognizer(target: contentView, action: #selector(contentView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tap)
    }
    
    func showLoadingDialog(message: String) {
        loadingDialog = LoadingDialogVC()
        loadingDialog!.dialogText = message
        loadingDialog!.modalPresentationStyle = .overFullScreen
        loadingDialog!.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            self.present(self.loadingDialog!, animated: true, completion: nil)
        }
    }
    
    func hideLoadingDialog(completion: (() -> Void)?) {
        loadingDialog!.dismissDialog(completion: completion)
    }
    
    func showDialog(dialogData: DialogModel, accept: (() -> Void)?) {
        
        let alert = UIAlertController(title: dialogData.title, message: dialogData.content, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: dialogData.buttonAccept ?? Constants.Common.btnAccept, style: .default) { (action:UIAlertAction) in
            (accept ?? {})()
        }
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showInternetConnectionError(onDismiss: (() -> Void)?) {
        var dialogData = DialogModel()
        dialogData.title = Constants.Common.lblNoInternetTitle
        dialogData.content = Constants.Common.lblNoInternet
        dialogData.buttonAccept = Constants.Common.btnAccept
        self.showDialog(dialogData: dialogData, accept: nil)
    }
    
    
    @objc func navigateBack(sender: Any?) {
        if let navigator = self.navigationController {
            navigator.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: Other methods
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
