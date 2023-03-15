//
//  HomeView.swift
//  SECC
//
//  Created by Mateus Amorim on 08/03/23.
//

import UIKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    var categoryCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (frame.size.width/2) - 4, height: (HomeView.frame.size.width/2) - 4)
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 1
//        layout.minimumLineSpacing = 1
//        
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
//        collection.dataSource = self
//        collection.delegate = self
//        collection.backgroundColor = .clear
//        return collection
//    }()
}
