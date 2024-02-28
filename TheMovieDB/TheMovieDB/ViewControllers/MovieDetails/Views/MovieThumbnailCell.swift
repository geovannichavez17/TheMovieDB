//
//  MovieThumbnailCell.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import UIKit
import AlamofireImage

class MovieThumbnailCell: UICollectionViewCell {
    
    lazy var cellContent: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "youtube")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .yellow
        // Adding
        cellContent.addSubview(photoImageView)
        cellContent.addSubview(titleLabel)
        cellContent.addSubview(playIcon)
        contentView.addSubview(cellContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellContent.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalTo: cellContent.widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: cellContent.heightAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: cellContent.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: cellContent.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            playIcon.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            playIcon.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            playIcon.heightAnchor.constraint(equalToConstant: 55),
            playIcon.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: cellContent.widthAnchor, multiplier: 0.90),
            titleLabel.centerXAnchor.constraint(equalTo: cellContent.centerXAnchor)
        ])
        
        /*NSLayoutConstraint.activate([
         titleLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 12),
         titleLabel.leftAnchor.constraint(equalTo: photoImageView.leftAnchor),
         titleLabel.rightAnchor.constraint(equalTo: self.cellContent.rightAnchor)
         ])*/
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(item: VideoThumbnail) {
        titleLabel.text = item.title?.uppercased()
        guard let photoUrl = URL(string: item.thumbnailUrl ?? "") else { return }
        photoImageView.af.setImage(withURL: photoUrl, placeholderImage: UIImage(named: "ic_profile_placeholder"))
    }
    
}
