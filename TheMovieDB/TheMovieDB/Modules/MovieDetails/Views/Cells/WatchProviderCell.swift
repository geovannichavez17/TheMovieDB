//
//  WatchProviderCell.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import UIKit

class WatchProviderCell: UICollectionViewCell {
    
    lazy var cellContent: UIView = {
        return UIView()
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellContent.addSubview(photoImageView)
        contentView.addSubview(cellContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellContent.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: cellContent.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(imageUrl: URL) {
        photoImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "ic_profile_placeholder"))
    }
    
}
