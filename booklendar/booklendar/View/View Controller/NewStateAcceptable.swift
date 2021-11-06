//
//  NewStateAcceptable.swift
//  booklendar
//
//  Created by Song on 2021/10/18.
//

import Foundation

protocol NewStateAcceptable {
    func accept<State>(newState: State)
}
