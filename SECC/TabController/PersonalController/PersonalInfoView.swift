//
//  PersonalInfoView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import Foundation
import SnapKit

class PersonalInfoView: UIView {
    
    var userEmail: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var userName: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var userPassword: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var userSurname: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var userBlock: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var userApart: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserInformation(email: String, name: String, surname: String, password: String, block: String, apart: String) {
        self.userEmail.text = "Email: \(email)"
        self.userPassword.text = "Senha: \(password)"
        self.userName.text = "Nome: \(name)"
        self.userSurname.text = "Sobrenome: \(surname)"
        self.userBlock.text = "Bloco: \(block)"
        self.userApart.text = "Apartamento: \(apart)"
    }
    
}

extension PersonalInfoView: ConfigurationView {
    func viewHierarchy() {
        addSubview(userEmail)
        addSubview(userPassword)
        addSubview(userName)
        addSubview(userSurname)
        addSubview(userBlock)
        addSubview(userApart)
    }
    
    func setConstrants() {
        userEmail.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.leading.equalToSuperview()
        }
        
        userPassword.snp.makeConstraints { make in
            make.top.equalTo(userEmail.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userPassword.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
        
        userSurname.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
        
        userBlock.snp.makeConstraints { make in
            make.top.equalTo(userSurname.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
        
        userApart.snp.makeConstraints { make in
            make.top.equalTo(userBlock.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
    }
}
