//
//  MovieCrewView.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

class MovieCrewView: UIView {
    private let crewCollectionViewCellID = "crewCollectionViewCellID"

    lazy var crewLabel: UILabel = {
        let label = UILabel()
        label.text = "Crew"
        label.textColor = .algaeGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var crewCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCrewCell.self, forCellWithReuseIdentifier: self.crewCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let cellReuseID = "cellReuseID"
    
    
    var cellItems: [Cast]! {
        didSet {
            crewCollectionView.reloadData()
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
        addSubview(crewLabel)
        addSubview(crewCollectionView)
    }
    
    private func createConstraints() {
    
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: crewCollectionView.bottomAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            crewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            crewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            crewLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            crewCollectionView.topAnchor.constraint(equalTo: crewLabel.bottomAnchor, constant: 12),
            crewCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            crewCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            crewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            crewCollectionView.heightAnchor.constraint(equalToConstant: 125),
        ])
    }

}


extension MovieCrewView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.crewCollectionViewCellID, for: indexPath) as! MovieCrewCell
        let currentItem = cellItems[indexPath.row]
        cell.set(item: currentItem)
        return cell
    }
}

extension MovieCrewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 24.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 125)
    }
}
