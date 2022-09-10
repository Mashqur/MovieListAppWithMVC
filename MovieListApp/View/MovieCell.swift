//
//  movieCell.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 9/9/22.
//

import UIKit

class MovieCell: UITableViewCell {
    static let identifier = "cell"
    
    private let moviePoster: CustomImageView = {
        let moviePoster = CustomImageView()
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.clipsToBounds = true
        moviePoster.layer.masksToBounds = true
        moviePoster.heightAnchor.constraint(equalToConstant: 80).isActive = true
        moviePoster.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return moviePoster
    }()
    
    private let movieName: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .preferredFont(forTextStyle: .headline)
        title.textColor = .systemGray
        title.numberOfLines = 0
        return title
    }()
    
    private let movieOverview: UILabel = {
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = .preferredFont(forTextStyle: .subheadline)
        overview.textColor = .systemGray
        overview.numberOfLines = 0
        return overview
    }()
    
    private let hStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .fill
        return hStack
    }()
    
    private let hStackMoviePosterView: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .center
        return hStack
    }()
    
    private let vStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .firstBaseline
        return vStack
    }()
    
    private func setUpCell() {
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(hStackMoviePosterView)
        hStackView.addArrangedSubview(vStackView)
        hStackMoviePosterView.addArrangedSubview(moviePoster)
        vStackView.addArrangedSubview(movieName)
        vStackView.addArrangedSubview(movieOverview)
        
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: Movie) {
        movieName.text = movie.name
        movieOverview.text = movie.overview
        let imageURL = "https://image.tmdb.org/t/p/w200" + movie.poster_url
        if let url = URL(string: imageURL ) {
            moviePoster.loadImageWithUrl(url)
        }
        print("Himel \(movie.poster_url)")
    }
    
}
