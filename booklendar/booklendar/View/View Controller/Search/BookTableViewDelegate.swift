//
//  BookTableViewDelegate.swift
//  booklendar
//
//  Created by Song on 2021/11/01.
//

import UIKit

typealias BookTableHandler = (BookTableAction) -> Void

enum BookTableAction {
    case selectedAt(IndexPath)
}

final class BookTableViewDelegate: NSObject {
    private let rowHeight: CGFloat = 65
    private var actionHandler: BookTableHandler?
    
    required init(actionHandler: @escaping BookTableHandler) {
        self.actionHandler = actionHandler
        super.init()
    }
}

extension BookTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionHandler?(.selectedAt(indexPath))
    }
}
