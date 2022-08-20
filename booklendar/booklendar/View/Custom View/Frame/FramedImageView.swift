//
//  FramedImageView.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

final class FramedImageView: UIView {
    enum Style: CaseIterable {
        case rectangle
        case corneredRectangle
        case diamond
        case oval
        
        var image: UIImage? {
            switch self {
            case .rectangle:
                return UIImage(named: "frame_rectangle")
            case .corneredRectangle:
                return UIImage(named: "frame_cornered_rectangle")
            case .diamond:
                return UIImage(named: "frame_diamond")
            case .oval:
                return UIImage(named: "frame_oval")
            }
        }
        
        static func random() -> Style {
            return Style.allCases.randomElement() ?? .rectangle
        }
    }
    
    private lazy var frameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
    }
    
    private func addSubView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(frameImageView)
        NSLayoutConstraint.activate([
            frameImageView.topAnchor.constraint(equalTo: topAnchor),
            frameImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            frameImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with image: UIImage, style: Style) {
        imageView.image = image
        frameImageView.image = style.image
    }
    
    func reset() {
        imageView.image = nil
        frameImageView.image = nil
    }
}
