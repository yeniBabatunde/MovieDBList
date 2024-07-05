//
//  ListCell.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI
import NetworkHandling

struct ListCell: View {
    var title: String
    var imageUrlString: String
    var rating: String
    @ObservedObject var viewModel: ImageLoaderViewModel
    
    var body: some View {
        HStack {
            if let data = viewModel.data, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 130, height: 70)
                    .cornerRadius(5)
                    .background(Color.clear)
            } else {
                ZStack {
                    Image(systemName: "video.slash")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 130, height: 70)
                        .background(Color.gray)
                        .cornerRadius(5)
                    
                    ActivityIndicator(style: .medium)
                        .onAppear {
                            viewModel.fetchImageUrlString(urlString: imageUrlString, completion: {})
                        }
                }
                .background(Color.clear)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text("Rating: \(rating) ⭐")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.2)
            }
            .background(Color.clear)
        }
        .background(Color.clear)
        .cornerRadius(10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let networkHandler = NetworkHandler(apiKey: AppConstants.API_KEY)
        ContentView(viewModel: MovieViewModel(networkHandler: networkHandler))
    }
}

