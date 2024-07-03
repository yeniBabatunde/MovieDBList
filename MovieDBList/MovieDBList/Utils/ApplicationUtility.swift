//
//  ApplicationUtility.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import Foundation

typealias EmptyCallback = () -> Void
typealias BooleanCallback = (_ done: Bool) -> Void
typealias OnCompletionCallback<T> = (_ val: T)-> Void
typealias DualValueChangeCallback<V, T> = (_ val1: V, _ val2: T)-> Void
