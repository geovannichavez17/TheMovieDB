//
//  MoviesVC.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import UIKit

class MoviesVC: BaseVC {

    // Global
    let collectionViewCellID = "collectionViewCellID"
    var viewModel: MoviesViewModel?
    var selectedFilter: Categories = .nowPlaying
    var viewAlreadyAppeared = false
    
    lazy var segmentedFilters: UISegmentedControl = {
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

    func set(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewAlreadyAppeared {
            viewModel?.retrieveMovies(from: selectedFilter)
            viewAlreadyAppeared = true
        }
    }
    
    func renderUI() {
        // Navigation bar
        self.setNavigationBar(title: "Movies")
        self.configureContentView()
        
        // Elements
        segmentedFilters = UISegmentedControl(items: Categories.allCases.map { $0.rawValue })
        segmentedFilters.selectedSegmentIndex = 0
        segmentedFilters.selectedSegmentTintColor = .customGray
        segmentedFilters.backgroundColor = .lightLayer
        segmentedFilters.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        segmentedFilters.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)], for: .selected)
        segmentedFilters.translatesAutoresizingMaskIntoConstraints = false
        segmentedFilters.addTarget(self, action: #selector(onFilterSelected), for: .valueChanged)
        
        // Adding to view
        self.contentView.addSubview(segmentedFilters)
        self.contentView.addSubview(gridCollectionView)
        
        
        // Layout
        NSLayoutConstraint.activate([
            segmentedFilters.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedFilters.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23),
            segmentedFilters.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23),
            segmentedFilters.heightAnchor.constraint(equalToConstant: 28)
        ])
        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: segmentedFilters.bottomAnchor, constant: 23),
            gridCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 9),
            gridCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            gridCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -9)
        ])
    }
    
    
    private func bindViewModel() {
        viewModel?.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingDialog()
                } else {
                    self.hideLoadingDialog(completion: nil)
                }
            }
        }
        
        viewModel?.errorMessage.bind{ [weak self] message in
            guard let self = self else { return }
            guard let message = message else { return }
            DispatchQueue.main.async {
                let title = Constants.Common.titleError
                self.showAlert(title: title, message: message, accept: nil)
            }
        }
        
        viewModel?.moviesDataSource.bind { [weak self] movies in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.gridCollectionView.reloadData()
            }
        }
        
    }

    @objc func onFilterSelected() {
        let index = segmentedFilters.selectedSegmentIndex
        guard let filter = segmentedFilters.titleForSegment(at: index) else { return }
        guard let category = Categories(rawValue: filter) else { return }
        selectedFilter = category
        viewModel?.retrieveMovies(from: selectedFilter)
    }
}

extension MoviesVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.moviesDataSource.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellID, for: indexPath) as! MoviesViewCell
        guard let item = viewModel?.moviesDataSource.value?[indexPath.row] else { return cell }
        cell.set(item: item)
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

extension MoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = viewModel?.moviesDataSource.value?[indexPath.row] else { return }
        viewModel?.coordinator?.navigateToDetails(movie: selectedItem)
    }
}

extension MoviesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (gridCollectionView.contentSize.height-100 - gridCollectionView.frame.size.height) {
            guard let isLoading = viewModel?.isLoading.value else { return }
            guard !isLoading else { return }
            viewModel?.retrieveMovies(from: selectedFilter)
            
        }
    }
}
