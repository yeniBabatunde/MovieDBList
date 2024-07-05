//
//  MovieDetailsViewControllerRepresentable.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI
import NetworkHandling

struct MovieDetailsViewControllerRepresentable: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }
    var movieList: TrendingListItem
    var networkHandler: NetworkHandling
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MovieDetailsViewControllerRepresentable>) -> UIViewController {
        
        return SelectedTrendingMovieDetailsViewController(selectedItem: movieList, networkHandler: networkHandler)
      
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<MovieDetailsViewControllerRepresentable>) {
        if let newController = uiViewController.navigationController {
            self.configure(newController)
        }
    }
}

