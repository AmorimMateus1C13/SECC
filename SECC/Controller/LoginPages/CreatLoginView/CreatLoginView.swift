//
//  CreatLoginView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//


import UIKit
import SnapKit

class CreatLoginView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var stackVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()
    
    var newEmail: UITextField = {
        let new = UITextField()
        new.font = UIFont.systemFont(ofSize: 18)
        new.placeholder = "Novo email: "
        new.backgroundColor = .white
        new.layer.cornerRadius = 5
        return new
    }()
    
    var newPassword: UITextField = {
        let new = UITextField()
        new.font = UIFont.systemFont(ofSize: 18)
        new.placeholder = "Nova senha: "
        new.backgroundColor = .white
        new.layer.cornerRadius = 5
        return new
    }()
    
    var buttonToCreat: UIButton = {
        let button = UIButton()
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.backgroundColor = Colors.addInCartBackButton
        button.layer.cornerRadius = 5
        return button
    }()
    
}

extension CreatLoginView: ConfigurationView {
    func viewHierarchy() {
        addSubview(stackVertical)
        stackVertical.addArrangedSubview(newEmail)
        stackVertical.addArrangedSubview(newPassword)
        stackVertical.addArrangedSubview(buttonToCreat)
    }
    
    func setConstrants() {
        stackVertical.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        newEmail.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.trailing.leading.equalToSuperview()
        }
        
        newPassword.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.trailing.leading.equalToSuperview()
        }
        
        buttonToCreat.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(75)
        }
    }
    
    
}
