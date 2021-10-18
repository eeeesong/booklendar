//
//  ViewModelIncludable.swift
//  booklendar
//
//  Created by Song on 2021/10/16.
//

import Foundation

protocol ViewModelIncludable {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
    mutating func set(_ viewModel: ViewModel)
}

extension ViewModelIncludable {
    mutating func set(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
