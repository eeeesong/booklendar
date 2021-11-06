//
//  UITableViewCell + Reusable.swift
//  booklendar
//
//  Created by Song on 2021/11/01.
//

import UIKit

extension UITableViewCell: Reusable {
    static var identifier: String = {
        return String(describing: self)
    }()
}
