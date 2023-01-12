//
//  ItemsCollectionViewCell.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit

class ItemsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        backgroundColor = .systemFill
        layer.cornerRadius = 5
        reloadInputViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "ItemsCollectionViewCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    var imageItem: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        
        return image
    }()
    
    var productValue: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 14)
        value.textAlignment = .center
        return value
    }()
    
    func changeImage(image: UIImage, title: String, value: String)  {
        imageItem.image = image
        titleLabel.text = title
        productValue.text = value
    }
}

extension ItemsCollectionViewCell: ConfigurationView {
    
    func viewHierarchy() {
        addSubview(imageItem)
        addSubview(productValue)
        addSubview(titleLabel)
    }
    
    func setConstrants() {
        imageItem.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(120)
            make.trailing.leading.equalToSuperview()
        }
        
        productValue.snp.makeConstraints { make in
            make.top.equalTo(imageItem.snp.bottom)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productValue.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
    }
}
