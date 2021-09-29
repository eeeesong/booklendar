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
        let size = ScreenSize.height * 0.038
        return UIFont.systemFont(ofSize: size, weight: .heavy)
    }
    
    static func smallCalendarTitle() -> UIFont {
        let size = ScreenSize.height * 0.021
        return UIFont.systemFont(ofSize: size, weight: .heavy)
    }
    
    static func date() -> UIFont {
        let size = ScreenSize.height * 0.016
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func bookTitle() -> UIFont {
        let size = ScreenSize.height * 0.023
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func body() -> UIFont {
        let size = ScreenSize.height * 0.02
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
}
