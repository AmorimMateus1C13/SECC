//
//  LoginView.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import UIKit
import SnapKit

protocol ButtonsOfLogin {
    func loginButton()
    func forgotButton()
    func creatButton()
}

class LoginView: UIView {
    var delegate: ButtonsOfLogin?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    var emailTxt: UITextField = {
        let login = UITextField()
        login.layer.cornerRadius = 5
        login.font = UIFont.systemFont(ofSize: 21)
        login.textColor = .black
        login.keyboardType = .emailAddress
        login.placeholder = "Email:"
        login.backgroundColor = .white
        return login
    }()
    
    var alertEmail: UILabel = {
        let alert = UILabel()
        alert.textColor = .systemRed
        alert.backgroundColor = .clear
        return alert
    }()
    
    var passwordTxt: UITextField = {
        let pass = UITextField()
        pass.layer.cornerRadius = 5
        pass.font = UIFont.systemFont(ofSize: 21)
        pass.textColor = .black
        pass.placeholder = "Password:"
        pass.backgroundColor = .white
        return pass
    }()
    
    var alertpass: UILabel = {
        let alert = UILabel()
        alert.textColor = .systemRed
        alert.backgroundColor = .clear
        return alert
    }()
    
    var loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        login.setTitle("Entrar", for: .normal)
        login.setTitleColor(UIColor(ciColor: .white), for: .normal)
        login.backgroundColor = Colors.addInCartBackButton
        login.layer.cornerRadius = 5
        login.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return login
    }()
    
    var forgetPass: UIButton = {
        let forget =  UIButton(type: .system)
        forget.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        forget.setTitle("Esqueci a senha", for: .normal)
        forget.setTitleColor(UIColor(ciColor: .gray), for: .normal)
        forget.addTarget(self, action: #selector(forgotPressed), for: .touchUpInside)
        return forget
    }()
    
    
    var creatAccount: UIButton = {
        let creat = UIButton(type: .system)
        creat.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        creat.setTitle("Criar Conta", for: .normal)
        creat.setTitleColor(UIColor(ciColor: .gray), for: .normal)
        creat.addTarget(self, action: #selector(creatPressed), for: .touchUpInside)
        return creat
    }()
  
}

//MARK: - Buttons Functions
extension LoginView {
    
    @objc func loginPressed() {
        delegate?.loginButton()
    }
    
    @objc func creatPressed() {
        delegate?.creatButton()
    }
    
    @objc func forgotPressed() {
        delegate?.forgotButton()
    }
}

extension LoginView: ConfigurationView {
    
    func viewHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(emailTxt)
        stack.addArrangedSubview(alertEmail)
        stack.addArrangedSubview(passwordTxt)
        stack.addArrangedSubview(alertpass)
        stack.addArrangedSubview(loginButton)
        
        addSubview(forgetPass)
        addSubview(creatAccount)
    }
    
    func setConstrants() {
        
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        emailTxt.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(30)
        }
        
        alertEmail.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        passwordTxt.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(30)
        }
        
        alertpass.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(75)
        }
        
        forgetPass.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        creatAccount.snp.makeConstraints { make in
            make.top.equalTo(forgetPass.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
}
