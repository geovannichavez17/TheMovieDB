//
//  MoviesVC.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import UIKit

class MoviesVC: BaseVC, MoviesView {

    // Global
    let collectionViewCellID = "collectionViewCellID"
    var tvShowsList = [Movie]()
    
    
    lazy var scFilters: UISegmentedControl = {
        let filtersSegments = UISegmentedControl()
        filtersSegments.selectedSegmentIndex = 0
        filtersSegments.selectedSegmentTintColor = .customGray
        filtersSegments.backgroundColor = .lightLayer
        return filtersSegments
    }()
    
    lazy var gridCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        let moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        moviesCollectionView.backgroundColor = .clear
        moviesCollectionView.register(MoviesViewCell.self, forCellWithReuseIdentifier: self.collectionViewCellID)
        //moviesCollectionView.delegate = self
        //moviesCollectionView.dataSource = self
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return moviesCollectionView
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI(filters: ["Now Playing", "Popular", "Top Rated", "Upcoming"])
    }
    
    func renderUI(filters: [String]) {
        // Creates menu action
        
        self.setNavigationBar(title: "Movies")
        self.configureContentView()
        
        // DEFINITION
        scFilters = UISegmentedControl(items: filters)
        scFilters.selectedSegmentIndex = 0
        scFilters.selectedSegmentTintColor = .customGray
        scFilters.backgroundColor = .lightLayer
        scFilters.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        scFilters.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)], for: .selected)
        scFilters.translatesAutoresizingMaskIntoConstraints = false
        scFilters.addTarget(self, action: #selector(onFilterSelected), for: .valueChanged)
        
        
        // ADDING
        self.contentView.addSubview(scFilters)
        
        
        // POSITIONS
        NSLayoutConstraint.activate([
            scFilters.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scFilters.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23),
            scFilters.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23),
            scFilters.heightAnchor.constraint(equalToConstant: 28)
        ])

        // Next render
        //self.presenter.retreieveTVShows(filter: .popular)
    }
    
    func renderTVShows() {
        /*self.tvShowsList = tvShows
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        
        if gridCollectionView == nil {
            gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            gridCollectionView?.backgroundColor = .clear
            gridCollectionView?.register(TVShowViewCell.self, forCellWithReuseIdentifier: self.collectionViewCellID)
            gridCollectionView?.delegate = self
            gridCollectionView?.dataSource = self
            gridCollectionView?.translatesAutoresizingMaskIntoConstraints = false
            
            // Adding to view
            self.contentView.addSubview(gridCollectionView)
            
            // AutoLayout
            NSLayoutConstraint.activate([
                gridCollectionView.topAnchor.constraint(equalTo: scFilters.bottomAnchor, constant: 23),
                gridCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 9),
                gridCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                gridCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -9)
            ])
        }
        else {
            gridCollectionView?.reloadData()
        }*/
    }
    
    func showGenericDialog(content: String, completion: (() -> Void)?) {
        var dialogData = DialogModel()
        dialogData.title = "TV Shows"
        dialogData.content = content
        dialogData.buttonAccept = Constants.Common.btnAccept
        self.showDialog(dialogData: dialogData, accept: completion)
    }
    
    // MARK: Other methods
    @objc func onFilterSelected() {
        /*var selectedFilter: tvShowFilter
        
        switch scFilters.selectedSegmentIndex {
        case 1:
            selectedFilter = .topRated
        case 2:
            selectedFilter = .onTV
        case 3:
            selectedFilter = .airingToday
        default:
            selectedFilter = .popular
        }
        
        self.presenter.retreieveTVShows(filter: selectedFilter)*/
    }
    
    @objc func navbarMenu() {
        /*let actionAlert = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        actionAlert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (UIAlertAction) in
            self.presenter.handleSignout()
        }))
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
            print("User canceled")
        }))
        self.present(actionAlert, animated: true, completion: nil)*/
    }
}

extension MoviesVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tvShowsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellID, for: indexPath) as! MoviesViewCell
        cell.set(item: self.tvShowsList[indexPath.row])
        return cell
    }
}

extension MoviesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 0, bottom: 2.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2
        return CGSize(width: widthPerItem - 6, height: 350)
    }

}





import SwiftUI
struct HomePreviews: PreviewProvider {
    static var previews: some View {
        GenericViewControllerPreview({ MoviesVC() }).previewDevice(.init(stringLiteral: "iPhone 11"))
    }
}
