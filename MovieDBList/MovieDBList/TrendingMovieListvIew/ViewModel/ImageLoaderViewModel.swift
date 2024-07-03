//
//  MovieCellViewModel.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation
import Combine
import UIKit

class ImageLoaderViewModel: ObservableObject {
    @Published var data: Data?
    
    private var networkHandler: NetworkHandling
    private var cancellable: AnyCancellable?
    
    init(networkHandler: NetworkHandling) {
        self.networkHandler = networkHandler
    }
    
    func fetchImageUrlSring(urlString: String, completion: @escaping () -> Void) {
        if let cachedData = getCachedImageData(for: urlString) {
            self.data = cachedData
            completion()
        } else {
            cancellable = networkHandler.fetchImage(urlString: "\(AppConstants.IMAGE_BASE_URL)\(urlString)")
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                    DispatchQueue.main.async {
                        self?.data = data
                        self?.cacheImageData(data, for: urlString)
                        completion()
                    }
                })
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

