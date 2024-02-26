//
//  MoviesViewCell.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import UIKit

class MoviesViewCell: UICollectionViewCell {
    
    var cellContent: UIView = {
        let cellContent = UIView()
        cellContent.layer.cornerRadius = 15
        cellContent.layer.masksToBounds = true
        cellContent.clipsToBounds = true
        return cellContent
    }()
    
    lazy var imgBannerShow: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bottomContent: UIView = {
        var view = UIView()
        view.backgroundColor = .dark
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lblShowName: UILabel = {
        let label = UILabel()
        label.textColor = .algaeGreen
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var lblRating: UILabel = {
        let label = UILabel()
        label.textColor = .algaeGreen
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lblDate: UILabel = {
        let label = UILabel()
        label.textColor = .algaeGreen
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lblOverview: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomContent.addSubview(lblShowName)
        bottomContent.addSubview(lblRating)
        bottomContent.addSubview(lblDate)
        bottomContent.addSubview(lblOverview)
        cellContent.addSubview(imgBannerShow)
        cellContent.addSubview(bottomContent)
        contentView.addSubview(cellContent)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellContent.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            imgBannerShow.topAnchor.constraint(equalTo: cellContent.topAnchor),
            imgBannerShow.leftAnchor.constraint(equalTo: cellContent.leftAnchor),
            imgBannerShow.rightAnchor.constraint(equalTo: cellContent.rightAnchor),
            imgBannerShow.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -115)
        ])
        
        NSLayoutConstraint.activate([
            bottomContent.leftAnchor.constraint(equalTo: cellContent.leftAnchor),
            bottomContent.rightAnchor.constraint(equalTo: cellContent.rightAnchor),
            bottomContent.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor),
            bottomContent.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            lblShowName.topAnchor.constraint(equalTo: bottomContent.topAnchor, constant: 10),
            lblShowName.leftAnchor.constraint(equalTo: bottomContent.leftAnchor, constant: 8),
            lblShowName.rightAnchor.constraint(equalTo: bottomContent.rightAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            lblRating.topAnchor.constraint(equalTo: lblShowName.bottomAnchor, constant: 11),
            lblRating.rightAnchor.constraint(equalTo: bottomContent.rightAnchor, constant: -8),
            lblRating.widthAnchor.constraint(equalTo: bottomContent.widthAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            lblDate.topAnchor.constraint(equalTo: lblShowName.bottomAnchor, constant: 11),
            lblDate.leftAnchor.constraint(equalTo: bottomContent.leftAnchor, constant: 8),
            lblDate.rightAnchor.constraint(equalTo: lblRating.leftAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            lblOverview.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 8),
            lblOverview.leftAnchor.constraint(equalTo: bottomContent.leftAnchor, constant: 9),
            lblOverview.rightAnchor.constraint(equalTo: bottomContent.rightAnchor, constant: -9),
            lblOverview.bottomAnchor.constraint(equalTo: bottomContent.bottomAnchor, constant: -9)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(item: Movie) {
        lblShowName.text = item.originalTitle
        lblOverview.text = item.overview
        lblRating.text = String(format: "⭑ %.1f", item.voteAverage)
        lblDate.text = item.releaseDate
        let posterUrl = "\(Constants.APIs.posterUrl)\(item.posterPath)"
        //imgBannerShow.sd_setImage(with: URL(string: posterUrl), placeholderImage: UIImage(named: "ic_picture_placeholder"))
    }
}
