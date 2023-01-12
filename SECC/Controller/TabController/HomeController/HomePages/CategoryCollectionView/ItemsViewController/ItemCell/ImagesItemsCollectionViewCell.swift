//
//  ImagesItemsCollectionViewCell.swift
//  SECC
//
//  Created by Mateus Amorim on 07/12/22.
//


import UIKit
import SnapKit

class ImagesItemsCollectionViewCell: UICollectionViewCell {

    static let identifier =  "ImagesItemsCollectionViewCell"

    var imageCollection: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeImage(image: UIImage) {
        imageCollection.image = image
//        imageCollection.image = UIImage(named: image)
    }
}

extension ImagesItemsCollectionViewCell: ConfigurationView {
    
    func viewHierarchy() {
        addSubview(imageCollection)
    }
    
    func setConstrants() {
        imageCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
