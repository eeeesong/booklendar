//
//  DetailDrawer.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import UIKit

final class DetailCollectionViewDrawer: NSObject {
    private let width = ScreenSize.width * 0.8
}

extension DetailCollectionViewDrawer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}
