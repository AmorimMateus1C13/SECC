//
//  ShopEmptyView.swift
//  SECC
//
//  Created by Mateus Amorim on 13/03/23.
//

import SnapKit

class ShopEmptyView: UIView {
    
    var labelAlert: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.italicSystemFont(ofSize: 21)
        label.text = " Nenhum item adicionado ao carrinho. "
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 30
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShopEmptyView: ConfigurationView {
    func viewHierarchy() {
        addSubview(labelAlert)
    }
    
    func setConstrants() {
        labelAlert.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(24)
        }
    }
}
