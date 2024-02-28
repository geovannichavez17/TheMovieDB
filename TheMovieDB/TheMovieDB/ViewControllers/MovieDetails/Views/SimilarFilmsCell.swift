//
//  SimilarFilmsCell.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import UIKit

class SimilarFilmsCell: UICollectionViewCell {
    
    lazy var cellContent: UIView = {
        return UIView()
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var labelGuide: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "labelGuide"
        return guide
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .semiTransparentBlack
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Adding
        cellContent.addSubview(photoImageView)
        cellContent.addLayoutGuide(labelGuide)
        cellContent.addSubview(nameLabel)
        contentView.addSubview(cellContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellContent.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.cellContent.topAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            labelGuide.topAnchor.constraint(equalTo: photoImageView.centerYAnchor, constant: 10),
            labelGuide.leftAnchor.constraint(equalTo: photoImageView.leftAnchor, constant: -10),
            labelGuide.rightAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 10),
            labelGuide.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: labelGuide.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: labelGuide.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalTo: labelGuide.widthAnchor, multiplier: 0.90)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(item: SimilarResult) {
        nameLabel.text = item.originalTitle
        
        let posterUrlStr = "\(Constants.APIs.profileImageUrl)/\(item.posterPath ?? "")"
        guard let posterUrl = URL(string: posterUrlStr) else { return }
        photoImageView.af.setImage(withURL: posterUrl, placeholderImage: UIImage(named: "ic_picture_placeholder"))
    }
    
}
