//
//  ShopCollectionView.swift
//  SECC
//
//  Created by Mateus Amorim on 13/03/23.
//

import Foundation
import UIKit
import SnapKit

class ShopCollectionView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2 - 16) , height: (UIScreen.main.bounds.width/2 - 4))
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ShoppingCell.self, forCellWithReuseIdentifier: ShoppingCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShopCollectionView: ConfigurationView {
    func viewHierarchy() {
        addSubview(collectionView)
    }
    
    func setConstrants() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
