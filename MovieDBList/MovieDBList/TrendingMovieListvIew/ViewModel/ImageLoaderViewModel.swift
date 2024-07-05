//
//  MovieCellViewModel.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation
import UIKit
import NetworkHandling

class ImageLoaderViewModel: ObservableObject {
    @Published var data: Data?
    
    private var networkHandler: NetworkHandling
    
    init(networkHandler: NetworkHandling) {
        self.networkHandler = networkHandler
    }
    
    func fetchImageUrlString(urlString: String, completion: @escaping () -> Void) {
        if let cachedData = getCachedImageData(for: urlString) {
            self.data = cachedData
            completion()
        } else {
            networkHandler.fetchImage(urlString: "\(AppConstants.IMAGE_BASE_URL)\(urlString)") { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.data = data
                        self?.cacheImageData(data, for: urlString)
                        completion()
                    }
                case .failure(let error):
                    print("Error fetching image: \(error)")
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
    
    private func getCachedImageData(for urlString: String) -> Data? {
        let fileURL = getFileURL(for: urlString)
        return try? Data(contentsOf: fileURL)
    }
    
    private func cacheImageData(_ data: Data, for urlString: String) {
        let fileURL = getFileURL(for: urlString)
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error caching image data: \(error)")
        }
    }
    
    private func getFileURL(for urlString: String) -> URL {
        let fileName = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? UUID().uuidString
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheDirectory.appendingPathComponent(fileName)
    }
}

