//
//  UICollectionViewCell + Reusable.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

protocol Reusable {
    static var identifier: String { get set }
}

extension UICollectionViewCell: Reusable {
    static var identifier: String = {
        return String(describing: self)
    }()
}
