//
//  SelectedTrendingMovieDetailsViewController.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import UIKit

class SelectedTrendingMovieDetailsViewController: UIViewController {
    
    private var selectedItem: TrendingListItem
    private var viewModel: ImageLoaderViewModel?
    private var networkHandler: NetworkHandling
    
    lazy var layout = SelectedTrendingMovieDetailsLayout()
    
    init(selectedItem: TrendingListItem, networkHandler: NetworkHandling) {
        self.selectedItem = selectedItem
        self.networkHandler = networkHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubviews(layout)
        
        layout.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewModel = ImageLoaderViewModel(networkHandler: networkHandler)
        
        viewModel?.fetchImageUrlSring(urlString: selectedItem.backdropPath ?? selectedItem.posterPath ?? "", completion: { [weak self] in
            self?.populateView()
        })
    }
    
    func populateView() {
        layout.movieTitleLabel.text = selectedItem.defaultTitle
        layout.descriptionLabel.text = selectedItem.overview
        if let data = viewModel?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async { [weak self] in
                self?.layout.detailsImage.image = image
            }
        }
    }
}
