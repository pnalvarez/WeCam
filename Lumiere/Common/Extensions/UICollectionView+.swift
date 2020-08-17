//
//  UICollectionView+.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias UICollectionViewProtocol = NSObject & UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

extension UICollectionView{
    
    func assignProtocols(to output: UICollectionViewProtocol) {
        dataSource = output
        delegate = output
    }
    
    func registerCell<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, type: T.Type) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}
