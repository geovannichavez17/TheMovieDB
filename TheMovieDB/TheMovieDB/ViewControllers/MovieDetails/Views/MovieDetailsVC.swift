//
//  MovieDetailsVC.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 26/2/24.
//

import UIKit

class MovieDetailsVC: BaseVC {
    
    private let crewCollectionViewCellID = "crewCollectionViewCellID"
    private let similarCollectionViewCellID = "similarCollectionViewCellID"
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .infoAreaBlack
        return view
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.textColor = .algaeGreen
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .algaeGreen
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trailerLabel: UILabel = {
        let label = UILabel()
        label.text = "Trailer"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trailerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        //collectionView.register(TVShowCastCell.self, forCellWithReuseIdentifier: self.collectionViewCellID)
        //collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
    lazy var crewLabel: UILabel = {
        let label = UILabel()
        label.text = "Crew"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var crewGuide: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "crewContainer"
        return guide
    }()
    
    lazy var crewCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.tag = 100
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCrewCell.self, forCellWithReuseIdentifier: self.crewCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    lazy var similarLabel: UILabel = {
        let label = UILabel()
        label.text = "Similar Movies"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var similarGuide: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "similarGuide"
        return guide
    }()
    
    lazy var similarCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.tag = 200
        collectionView.backgroundColor = .clear
        collectionView.register(SimilarFilmsCell.self, forCellWithReuseIdentifier: self.similarCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    /*lazy var similarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()*/
    
    
    lazy var whereLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to watch"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var whereContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rentLabel: UILabel = {
        let label = UILabel()
        label.text = "Rent"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buyLabel: UILabel = {
        let label = UILabel()
        label.text = "Buy"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buyContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: MovieDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
       renderUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.retrieveMovieDetails()
    }
    
    func set(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    func renderUI() {
        // Adds movie banner
        self.view.addSubview(bannerImage)
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            bannerImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            bannerImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: 210)
        ])
        
        // Create content
        self.setNavigationBar(title: nil)
        self.setTransparentNavbar()
        self.configureScrollableContentView()
        
        // Adding views to hierarchy
        content.addSubview(summaryLabel)
        content.addSubview(movieNameLabel)
        content.addSubview(overviewTitleLabel)
        content.addSubview(overviewLabel)
        content.addSubview(trailerLabel)
        content.addSubview(trailerCollectionView)
        content.addSubview(crewLabel)
        content.addSubview(crewCollectionView)
        content.addLayoutGuide(crewGuide)
        content.addSubview(similarLabel)
        content.addLayoutGuide(similarGuide)
        content.addSubview(similarCollectionView)
        content.addSubview(whereLabel)
        content.addSubview(whereContainer)
        content.addSubview(rentLabel)
        content.addSubview(rentContainer)
        content.addSubview(buyLabel)
        content.addSubview(buyContainer)
        contentView.addSubview(content)
        contentView.addSubview(ratingLabel)
        
        // Configures layout
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 86),
            content.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            content.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 20),
            summaryLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            summaryLabel.widthAnchor.constraint(equalTo: content.widthAnchor, multiplier: 0.60)
        ])
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 12),
            movieNameLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            movieNameLabel.widthAnchor.constraint(equalTo: content.widthAnchor, multiplier: 0.60)
        ])
        NSLayoutConstraint.activate([
            overviewTitleLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            overviewTitleLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            overviewTitleLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 12),
            overviewLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            overviewLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            trailerLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 40),
            trailerLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            trailerLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            trailerCollectionView.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 12),
            trailerCollectionView.leftAnchor.constraint(equalTo: content.leftAnchor),
            trailerCollectionView.rightAnchor.constraint(equalTo: content.rightAnchor),
            trailerCollectionView.heightAnchor.constraint(equalToConstant: 125)
        ])
        NSLayoutConstraint.activate([
            crewLabel.topAnchor.constraint(equalTo: trailerCollectionView.bottomAnchor, constant: 40),
            crewLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            crewLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            crewGuide.topAnchor.constraint(equalTo: crewLabel.bottomAnchor, constant: 12),
            crewGuide.leftAnchor.constraint(equalTo: content.leftAnchor),
            crewGuide.rightAnchor.constraint(equalTo: content.rightAnchor),
            crewGuide.heightAnchor.constraint(equalToConstant: 125),
        ])
        
        NSLayoutConstraint.activate([
            crewCollectionView.topAnchor.constraint(equalTo: crewGuide.topAnchor),
            crewCollectionView.leftAnchor.constraint(equalTo: crewGuide.leftAnchor),
            crewCollectionView.rightAnchor.constraint(equalTo: crewGuide.rightAnchor),
            crewCollectionView.bottomAnchor.constraint(equalTo: crewGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            similarLabel.topAnchor.constraint(equalTo: crewGuide.bottomAnchor, constant: 40),
            similarLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            similarLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            similarGuide.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 12),
            similarGuide.leftAnchor.constraint(equalTo: content.leftAnchor),
            similarGuide.rightAnchor.constraint(equalTo: content.rightAnchor),
            similarGuide.heightAnchor.constraint(equalToConstant: 180),
        ])
        NSLayoutConstraint.activate([
            similarCollectionView.topAnchor.constraint(equalTo: similarGuide.topAnchor),
            similarCollectionView.leftAnchor.constraint(equalTo: similarGuide.leftAnchor),
            similarCollectionView.rightAnchor.constraint(equalTo: similarGuide.rightAnchor),
            similarCollectionView.bottomAnchor.constraint(equalTo: similarGuide.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            whereLabel.topAnchor.constraint(equalTo: similarGuide.bottomAnchor, constant: 40),
            whereLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            whereLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            whereContainer.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 12),
            whereContainer.leftAnchor.constraint(equalTo: content.leftAnchor),
            whereContainer.rightAnchor.constraint(equalTo: content.rightAnchor),
            whereContainer.heightAnchor.constraint(equalToConstant: 125),
        ])
        NSLayoutConstraint.activate([
            rentLabel.topAnchor.constraint(equalTo: whereContainer.bottomAnchor, constant: 40),
            rentLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            rentLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            rentContainer.topAnchor.constraint(equalTo: rentLabel.bottomAnchor, constant: 12),
            rentContainer.leftAnchor.constraint(equalTo: content.leftAnchor),
            rentContainer.rightAnchor.constraint(equalTo: content.rightAnchor),
            rentContainer.heightAnchor.constraint(equalToConstant: 125),
        ])
        NSLayoutConstraint.activate([
            buyLabel.topAnchor.constraint(equalTo: rentContainer.bottomAnchor, constant: 40),
            buyLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 24),
            buyLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            buyContainer.topAnchor.constraint(equalTo: buyLabel.bottomAnchor, constant: 12),
            buyContainer.leftAnchor.constraint(equalTo: content.leftAnchor),
            buyContainer.rightAnchor.constraint(equalTo: content.rightAnchor),
            buyContainer.heightAnchor.constraint(equalToConstant: 125),
        ])
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: content.topAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -30),
            ratingLabel.heightAnchor.constraint(equalToConstant: 40),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: buyContainer.bottomAnchor),
            content.bottomAnchor.constraint(equalTo: buyContainer.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel?.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    // LOadinhg
                } else {
                    
                }
            }
        }
        
        viewModel?.movie.bind({ [weak self] movie in
            guard let self = self else { return }
            guard let bannerUrl = URL(string: "\(Constants.APIs.bannerImageUrl )/\(self.viewModel?.movie.value?.backdropPath ?? "")") else { return }
            DispatchQueue.main.async {
                self.bannerImage.af.setImage(withURL: bannerUrl)
                self.movieNameLabel.text = movie?.originalTitle
                self.overviewLabel.text = movie?.overview
                self.ratingLabel.text = String(format: "%.1f", movie?.voteAverage ?? 0.0)
            }
        })
        
        viewModel?.videos.bind({ [weak self] videos in
            guard let self = self else { return }
            print(videos)
        })
        
        viewModel?.crew.bind({ [weak self] crewList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.crewCollectionView.reloadData()
            }
        })
        
        viewModel?.similarFilms.bind({ [weak self] similarFilms in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.similarCollectionView.reloadData()
            }
        })
    }
}


extension MovieDetailsVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 200:
            return viewModel?.similarFilms.value?.count ?? 0
        default:
            return viewModel?.crew.value?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 200:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.similarCollectionViewCellID, for: indexPath) as! SimilarFilmsCell
            guard let currentItem = viewModel?.similarFilms.value?[indexPath.row] else { return UICollectionViewCell() }
            cell.set(item: currentItem)
            return cell
        default:
            // Crew
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.crewCollectionViewCellID, for: indexPath) as! MovieCrewCell
            guard let currentItem = viewModel?.crew.value?[indexPath.row] else { return UICollectionViewCell() }
            cell.set(item: currentItem)
            return cell
        }
    }
}

extension MovieDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView.tag {
        case 200:
            return UIEdgeInsets(top: 4.0, left: 24.0, bottom: 4.0, right: 4.0)
        default:
            // Crew
            return UIEdgeInsets(top: 4.0, left: 24.0, bottom: 4.0, right: 4.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 200:
            return CGSize(width: 100, height: 180)
        default:
            // Crew
            return CGSize(width: 100, height: 125)
        }
    }
}


import SwiftUI
struct DetailsPreviews: PreviewProvider {
    static var previews: some View {
        GenericViewControllerPreview({ MovieDetailsVC() }).previewDevice(.init(stringLiteral: "iPhone 11"))
    }
}
