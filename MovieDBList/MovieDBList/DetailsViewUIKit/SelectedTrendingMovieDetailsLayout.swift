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
        var stackViewContainerView = UIStackView(arrangedSubviews: [movieTitleLabel, containerView, descriptionLabel])
        stackViewContainerView.axis = .vertical
        stackViewContainerView.distribution = .fill
        stackViewContainerView.spacing = 10
        return stackViewContainerView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        var movieTitleLabel = UILabel()
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return movieTitleLabel
    }()
    
    lazy var detailsImage: UIImageView = {
        var detailsImage = UIImageView()
        detailsImage.image = UIImage(systemName: "video.slash")
        detailsImage.contentMode = .scaleAspectFill
        detailsImage.tintColor = .lightGray
        detailsImage.clipsToBounds = true
        detailsImage.layer.cornerRadius = 12
        return detailsImage
    }()
    
    lazy var containerView: UIView = {
        var containerView = UIView()
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return containerView
    }()
    
    lazy var activityView: UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView()
        activityView.backgroundColor = .white
        activityView.hidesWhenStopped = true
        activityView.style = .large
        return activityView
    }()
    
    lazy var descriptionLabel: UITextView = {
        var descriptionLabel = UITextView()
        descriptionLabel.textAlignment = .left
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        containerView.addSubview(detailsImage)
        detailsImage.addSubview(activityView)
        addSubviews(stackViewContainerView)
        
        detailsImage.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        activityView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(detailsImage)
        }
        
        stackViewContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        showLoading(true)
    }
    
    func showLoading(_ show: Bool) {
        if show {
            activityView.startAnimating()
        } else {
            activityView.stopAnimating()
        }
    }
    
}
