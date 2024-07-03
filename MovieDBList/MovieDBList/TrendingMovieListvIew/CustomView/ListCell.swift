//
//  ListCell.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI


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
            } else {
                ZStack {
                    Image("")
                        .resizable()
                        .frame(width: 130, height: 70)
                        .background(Color.gray)
                        .cornerRadius(5)
                    
                    ActivityIndicator(style: .medium)
                        .onAppear {
                            viewModel.fetchImageUrlSring(urlString: imageUrlString, completion: {})
                        }
                }
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text("Rating: \(rating) ⭐")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.2)
            }
            
       
        }
        .background(Color.white)
        .cornerRadius(10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let networkHandler = NetworkHandler()
        ContentView(viewModel: MovieViewModel(networkHandler: networkHandler))
    }
}

