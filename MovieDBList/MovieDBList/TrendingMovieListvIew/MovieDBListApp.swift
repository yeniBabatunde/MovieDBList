//
//  MovieDBListApp.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI
import NetworkHandling

@main
struct MovieDBListApp: App {
    var body: some Scene {
        WindowGroup {
            let networkHandler = NetworkHandler(apiKey: AppConstants.API_KEY)
            ContentView(viewModel: MovieViewModel(networkHandler: networkHandler))
        }
    }
}
