//
//  MovieCrewCell.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import UIKit
import AlamofireImage

class MovieCrewCell: UICollectionViewCell {
    
    lazy var cellContent: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Cell content
        //cellContent.backgroundColor = .lightGray

        // Adding
        cellContent.addSubview(photoImageView)
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
            //imgPhoto.leftAnchor.constraint(equalTo: self.cellContent.leftAnchor),
            //imgPhoto.rightAnchor.constraint(equalTo: self.cellContent.rightAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 12),
            nameLabel.leftAnchor.constraint(equalTo: self.cellContent.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.cellContent.rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.cellContent.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(item: Cast) {
        nameLabel.text = item.name
        
        let profilePicUrl = "\(Constants.APIs.profileImageUrl)/\(item.profilePath ?? "")"
        guard let photoUrl = URL(string: profilePicUrl) else { return }
        photoImageView.af.setImage(withURL: photoUrl, placeholderImage: UIImage(named: "ic_profile_placeholder"))
    }
}
