//
//  ListCategoryCell.swift
//  SECC
//
//  Created by Mateus Amorim on 15/12/22.
//

import UIKit
import SnapKit

class ListCategoryCell: UITableViewCell {

    static var identifier = "ListCategoryCell"
    
    var listaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = . black
        label.font  = UIFont.systemFont(ofSize: 21)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addInView()
        makeConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addInView() {
        addSubview(listaLabel)
    }
    
    func makeConstrants() {
        listaLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
