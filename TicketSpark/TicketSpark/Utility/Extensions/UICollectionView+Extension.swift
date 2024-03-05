//
//  UICollectionView+Extension.swift
//  TicketSpark
//
//  Created by Apple on 05/03/24.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionView {
    
   // self.collectionViewCoverImages.register(UINib(nibName: "CoverImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoverImageCollectionViewCell")
    
    
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        var nib = UINib(nibName: T.defaultReuseIdentifier, bundle:nil)
        self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
}
