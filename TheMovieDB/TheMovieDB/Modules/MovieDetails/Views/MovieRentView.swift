//
//  MovieRentView.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

class MovieRentView: UIView {
    
    private let whereCollectionViewCellID = "whereCollectionViewCellID"

    lazy var rentLabel: UILabel = {
        let label = UILabel()
        label.text = "Rent"
        label.textColor = .mainGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(WatchProviderCell.self, forCellWithReuseIdentifier: self.whereCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let cellReuseID = "cellReuseID"
    
    
    var cellItems: [WatchProvider]! {
        didSet {
            rentCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.createConstraints()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rentLabel)
        addSubview(rentCollectionView)
    }
    
    private func createConstraints() {
        
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: rentCollectionView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            rentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            rentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            rentCollectionView.topAnchor.constraint(equalTo: rentLabel.bottomAnchor, constant: 12),
            rentCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            rentCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            rentCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rentCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

}


extension MovieRentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.whereCollectionViewCellID, for: indexPath) as! WatchProviderCell
        let currentItem = cellItems[indexPath.row]
        let url = "\(Constants.APIs.profileImageUrl)/\(currentItem.logoPath ?? "")"
        guard let logoUrl = URL(string: url) else { return UICollectionViewCell() }
        cell.set(imageUrl: logoUrl)
        return cell
    }
}

extension MovieRentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 24.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
