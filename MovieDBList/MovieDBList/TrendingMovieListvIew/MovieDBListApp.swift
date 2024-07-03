//
//  MovieDBListApp.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import SwiftUI

@main
struct MovieDBListApp: App {
    var body: some Scene {
        WindowGroup {
            let networkHandler = NetworkHandler()
            ContentView(viewModel: MovieViewModel(networkHandler: networkHandler))
        }
    }
}
