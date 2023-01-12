//
//  ShoppingCell.swift
//  SECC
//
//  Created by Mateus Amorim on 28/12/22.
//

import UIKit
import SnapKit

protocol DeleteButtonAction {
    func deleteAction(currentTag: Int)
}

class ShoppingCell: UICollectionViewCell {
    
    var indexForDelete = [Int]()
    var delegate: DeleteButtonAction?
    static let identifier = "ShoppingCell"
    
    var buttonDelete: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = UIColor(red: 220 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
    func configCell(titleOfCell: String, imageOfCell: UIImage, productOfValue: String) {
        imageItem.image = imageOfCell
        titleLabel.text = titleOfCell
        productValue.text = "R$\(productOfValue)"
    }
    
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
}

extension ShoppingCell {
    @objc func buttonPressed(sender: UIButton) {
        delegate?.deleteAction(currentTag: sender.tag)
    }
}

extension ShoppingCell: ConfigurationView {
    func viewHierarchy() {
        addSubview(imageItem)
        addSubview(productValue)
        addSubview(titleLabel)
        addSubview(buttonDelete)
    }
    
    func setConstrants() {
        buttonDelete.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
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
