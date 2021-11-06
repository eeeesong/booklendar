//
//  BookTableView.swift
//  booklendar
//
//  Created by Song on 2021/11/01.
//

import UIKit

final class BookTableView: UITableView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerCell()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerCell()
    }
    
    private func registerCell() {
        register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
    }
}
