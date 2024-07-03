//
//  ContentView.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: MovieViewModel
    @State private var selectedItem: TrendingListItem?
    
    init(viewModel: MovieViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.trendingListItem, id: \.id) { item in
                    
                    NavigationLink(destination:
                                    MovieDetailsViewControllerRepresentable(movieList: item, networkHandler: viewModel.networkHandler)) {
                        ListCell(
                            title: item.defaultTitle,
                            imageUrlString: item.backdropPath ?? item.posterPath ?? "",
                            rating: "\(item.voteAverage ?? 0.0)",
                            viewModel: ImageLoaderViewModel(networkHandler: viewModel.networkHandler)
                        )
                    }
                                    .background(Color.clear)
                }
            }
            .navigationTitle("Movie List")
            .background(Color.clear)
            .onAppear {
                viewModel.getAllTrendingList()
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(
                    title: Text("An Error Occurred"),
                    message: Text(errorMessage.value),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
    }
}


struct ContentView_Previewss: PreviewProvider {
    static var previews: some View {
        let networkHandler = NetworkHandler()
        ContentView(viewModel: MovieViewModel(networkHandler: networkHandler))
    }
}
