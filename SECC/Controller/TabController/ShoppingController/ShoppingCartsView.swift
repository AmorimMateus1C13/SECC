//
//  ShoppingCartsView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import Foundation
import SnapKit

class ShoppingCarts: UIView {
    
    var labelAlert: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 15
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShoppingCarts: ConfigurationView {
    func viewHierarchy() {
        addSubview(labelAlert)
    }
    
    func setConstrants() {
        labelAlert.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
    }
}
