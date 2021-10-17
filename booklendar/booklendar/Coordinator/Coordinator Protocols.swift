//
//  Coordinator Protocols.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

protocol PopCoordinator {
    associatedtype State
    func pop(with state: State)
}

protocol PushCoordinator {
    associatedtype Info
    associatedtype Target: UIViewController
    func push(with info: Info, to targetViewController: Target)
}
