//
//  Font.swift
//  booklendar
//
//  Created by Song on 2021/09/29.
//

import UIKit

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

extension UIFont {
    static func bigCalendarTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .heavy)
    }
    
    static func smallCalendarTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .heavy)
    }
    
    static func date() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    static func bookTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    static func body() -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .medium)
    }
}
