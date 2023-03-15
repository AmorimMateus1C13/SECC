//
//  CustomCollectionViewCell.swift
//  SECC
//
//  Created by Mateus Amorim on 22/11/22.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    var imageItem: UIImageView = {
        let image = UIImageView()
        image.tintColor = .systemPink
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.isUserInteractionEnabled = true
        button.contentMode = .center
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 5
        button.tintColor = .systemPink
        button.clipsToBounds = true
        return button
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 21)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addInView()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryLabel.frame = CGRect(
            x: 5,
            y: contentView.frame.size.height - 50,
            width: contentView.frame.size.width - 10,
            height: 50)

        imageItem.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.frame.size.width - 10,
            height: contentView.frame.size.height - 50)
    }
    
    func addInView() {
        addSubview(imageItem)
        addSubview(categoryLabel)
    }
    
    func choiceImageButton(image: String) {

        imageItem.image = UIImage(systemName: image)
    }
    
    func choiceTitle(title: String) {
        categoryLabel.text = title
    }
}
