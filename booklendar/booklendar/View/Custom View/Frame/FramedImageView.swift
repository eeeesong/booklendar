//
//  FramedImageView.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

class FramedImageView: UIImageView {
    
    private lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = .white
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    enum FrameMode {
        case normal
        case searchEnabled
    }
    
    func changeMode(to mode: FrameMode) {
        switch mode {
        case .normal:
            removeSearchButton()
        case .searchEnabled:
            addSearchButton()
        }
    }
    
    private func addSearchButton() {
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            searchButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            searchButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    private func removeSearchButton() {
        searchButton.removeFromSuperview()
    }
}
