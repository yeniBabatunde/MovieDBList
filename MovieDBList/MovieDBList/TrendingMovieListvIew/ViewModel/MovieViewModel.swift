//
//  MovieViewModel.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI
import NetworkHandling

class MovieViewModel: ObservableObject {
    
    let networkHandler: NetworkHandling
    @Published var trendingListItem: [TrendingListItem] = []
    var selectedItem: TrendingListItem?
    @Published var errorMessage: IdentifiableString?
    @Published var onSuccess: OnCompletionCallback<Any>?
    @Published var selectedMovieID: Int?
    
    init(networkHandler: NetworkHandling) {
        self.networkHandler = networkHandler
    }
    
    func getAllTrendingList() {
        
        networkHandler.request(with: AppConstants.Endpoint.GET_ALL_TRENDING_LIST, method: .GET, body: nil, headers: nil) { [weak self] (result: Result<TrendingList, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.trendingListItem = data.results ?? []
                case .failure(let error):
                    self?.errorMessage?.value = error.localizedDescription
                }
            }
        }
    }
    
}
