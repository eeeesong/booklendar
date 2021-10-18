//
//  Coordinator Protocols.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

protocol PopCoordinator: AnyObject {
    associatedtype State
    func pop(with state: State)
}

protocol PushCoordinator: AnyObject {
    associatedtype Info
    associatedtype Target: UIViewController
    typealias SceneMaker = (Info) -> Target
    func push(with info: Info, sceneMaker: SceneMaker)
}
