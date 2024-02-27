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
    
    var viewModel: MoviesViewModel = MoviesViewModel()
    
    
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
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return moviesCollectionView
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI(filters: ["Now Playing", "Popular", "Top Rated", "Upcoming"])
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.retrieveMovies()
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
        self.contentView.addSubview(gridCollectionView)
        
        
        // POSITIONS
        NSLayoutConstraint.activate([
            scFilters.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scFilters.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23),
            scFilters.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23),
            scFilters.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: scFilters.bottomAnchor, constant: 23),
            gridCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 9),
            gridCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            gridCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -9)
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
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    // LOadinhg
                } else {
                    
                }
            }
        }
        
        viewModel.moviesDataSource.bind { [weak self] movies in
            guard let self = self else { return }
            //self.gridCollectionView.reloadData()
            DispatchQueue.main.async {
                self.gridCollectionView.reloadData()
            }
        }
        
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
            selectedFilter =
        case 3:
            selectedFilter = .airingToday
        default:
            selectedFilter = .popular
        }*/
        
        //self.presenter.retreieveTVShows(filter: selectedFilter)
    }
}

extension MoviesVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesDataSource.value?.count ?? 0
        //return viewModel.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellID, for: indexPath) as! MoviesViewCell
        guard let item = viewModel.moviesDataSource.value?[indexPath.row] else { return cell }
        cell.set(item: item)
        //cell.set(item: viewModel.moviesList[indexPath.row])
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
