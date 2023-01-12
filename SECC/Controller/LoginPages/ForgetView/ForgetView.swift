//
//  ForgetView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import Foundation
import SnapKit

class ForgetView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        backgroundColor = Colors.LoginView.backgroundView

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
    
    var newPassword: UITextField = {
        let new = UITextField()
        new.font = UIFont.systemFont(ofSize: 18)
        new.placeholder = "Nova senha: "
        new.backgroundColor = .white
        new.layer.cornerRadius = 5
        return new
    }()
    
    var passNewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.backgroundColor = Colors.addInCartBackButton
        button.layer.cornerRadius = 5
        return button
    }()
    
}

extension ForgetView: ConfigurationView {
    func viewHierarchy() {
        addSubview(stackVertical)
        stackVertical.addArrangedSubview(newPassword)
        stackVertical.addArrangedSubview(passNewButton)
    }
    
    func setConstrants() {
        stackVertical.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        newPassword.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.trailing.leading.equalToSuperview()
        }
        
        passNewButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(150)
        }
    }
}
