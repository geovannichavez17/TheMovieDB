//
//  SimilarMoviesView.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

class SimilarMoviesView: UIView {

    private let similarCollectionViewCellID = "similarCollectionViewCellID"

    lazy var similarLabel: UILabel = {
        let label = UILabel()
        label.text = "Similar Movies"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let cellReuseID = "cellReuseID"
    
    
    var cellItems: [SimilarResult]! {
        didSet {
            similarCollectionView.reloadData()
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
        addSubview(similarLabel)
        addSubview(similarCollectionView)
    }
    
    private func createConstraints() {
    
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: similarCollectionView.bottomAnchor, constant: 2)
        ])
        NSLayoutConstraint.activate([
            similarLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            similarLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            similarLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            similarCollectionView.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 12),
            similarCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            similarCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            similarCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            similarCollectionView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }

}


extension SimilarMoviesView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.similarCollectionViewCellID, for: indexPath) as! SimilarFilmsCell
        let currentItem = self.cellItems[indexPath.row]
        cell.set(item: currentItem)
        return cell
    }
}

extension SimilarMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 24.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 180)
    }
}
