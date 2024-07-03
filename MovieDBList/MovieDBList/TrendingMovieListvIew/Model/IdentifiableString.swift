//
//  IdentifiableString.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation

struct IdentifiableString: Identifiable {
    var id: String { self.value }
    var value: String
}
