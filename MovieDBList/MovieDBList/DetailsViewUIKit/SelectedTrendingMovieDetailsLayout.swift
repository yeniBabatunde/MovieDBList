//
//  SelectedTrendingMovieDetailsLayout.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import UIKit
import SnapKit

class SelectedTrendingMovieDetailsLayout: UIView {
    
    lazy var stackViewContainerView: UIStackView = {
     var stackViewContainerView = UIStackView(arrangedSubviews: [movieTitleLabel, detailsImage, descriptionLabel])
        stackViewContainerView.axis = .vertical
        stackViewContainerView.distribution = .fill
        stackViewContainerView.spacing = 10
        return stackViewContainerView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        var movieTitleLabel = UILabel()
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.numberOfLines = 0
        return movieTitleLabel
    }()
    
    lazy var detailsImage: UIImageView = {
        var detailsImage = UIImageView()
        detailsImage.contentMode = .scaleAspectFit
        detailsImage.backgroundColor = .lightGray
        detailsImage.clipsToBounds = true
        detailsImage.layer.cornerRadius = 12
        detailsImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return detailsImage
    }()
    
    lazy var descriptionLabel: UITextView = {
        var descriptionLabel = UITextView()
        descriptionLabel.textAlignment = .left
        descriptionLabel.backgroundColor = .white
        descriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return descriptionLabel
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setup() {
        addSubviews(stackViewContainerView)

       stackViewContainerView.snp.makeConstraints { make in
           make.top.equalToSuperview()
           make.leading.equalToSuperview().offset(20)
           make.trailing.equalToSuperview().inset(20)
       }

    }

}
