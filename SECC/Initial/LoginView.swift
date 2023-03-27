//
//  LoginView.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import UIKit
import SnapKit

protocol ButtonsOfLogin {
    func loginButton(blockAnApt: String, password: String)
    func forgotButton()
    func creatButton()
    func eyeButton(sender: UIButton)
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
    
    var stackVertical: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.backgroundColor = .clear
        return label
    }()
    
    var blockAndApt: UITextField = {
        let text = UITextField()
        text.text = "0987"
        text.textAlignment = .center
        text.layer.cornerRadius = 15
        text.font = UIFont.systemFont(ofSize: 21)
        text.autocapitalizationType = .none
        text.textColor = .black
        text.keyboardType = .numberPad
        text.placeholder = "Bloco e Apartamento"
        text.backgroundColor = .white
        return text
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Senha"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.backgroundColor = .clear
        return label
    }()
    
    var stackHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    
    var passwordTxt: UITextField = {
        let text = UITextField()
        text.text = "Cynthia123!"
        text.textAlignment = .center
        text.layer.cornerRadius = 15
        text.font = UIFont.systemFont(ofSize: 21)
        text.autocapitalizationType = .none
        text.textColor = .black
        text.placeholder = "Digite sua senha"
        text.backgroundColor = .white
        text.isSecureTextEntry = true
        return text
    }()
    
    var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(eyePressed), for: .touchUpInside)
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        config = config.applying(UIImage.SymbolConfiguration(pointSize: 15))
        if let image = UIImage(systemName: "eye",withConfiguration: config){
            button.setImage(image, for: .normal)
            button.contentMode = .scaleAspectFill
        }
        return button
    }()
    
    var loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        login.setTitle("Entrar", for: .normal)
        login.setTitleColor(UIColor(ciColor: .white), for: .normal)
        login.backgroundColor = Colors.addInCartBackButton
        login.layer.cornerRadius = 15
        login.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return login
    }()
    
    var forgetPass: UIButton = {
        let forget =  UIButton(type: .system)
        forget.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        forget.setTitle("Esqueci a senha", for: .normal)
        forget.setTitleColor(.systemBlue, for: .normal)
        forget.addTarget(self, action: #selector(forgotPressed), for: .touchUpInside)
        return forget
    }()
    
    var creatAccount: UIButton = {
        let creat = UIButton(type: .system)
        creat.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        creat.setTitle("Criar Conta", for: .normal)
        creat.setTitleColor(.systemBlue, for: .normal)
        creat.addTarget(self, action: #selector(creatPressed), for: .touchUpInside)
        return creat
    }()
    
    var myGit: UILabel = {
        let label = UILabel()
        label.text = "https://github.com/AmorimMateus1C13/"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 17)
        return label
    }()
    
    var seccLabel: UILabel = {
        let label = UILabel()
        label.text = "SECC"
        label.textColor = .gray
        label.font = .italicSystemFont(ofSize: 17)
        return label
    }()
  
    
    func changeEyeButton(button: UIButton, buttonImage: String, isSecureText: Bool) {
        passwordTxt.isSecureTextEntry = isSecureText
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        config = config.applying(UIImage.SymbolConfiguration(pointSize: 15))
        if let image = UIImage(systemName: buttonImage,withConfiguration: config){
            button.setImage(image, for: .normal)
            button.contentMode = .scaleAspectFill
        }
    }
}

//MARK: - Buttons Functions
extension LoginView {
    
    @objc func loginPressed() {
        guard let passwordSafe = passwordTxt.text else { return }
        guard let blockAnApt = blockAndApt.text else { return }
        
        delegate?.loginButton(blockAnApt: blockAnApt, password: passwordSafe)
    }
    
    @objc func creatPressed() {
        delegate?.creatButton()
    }
    
    @objc func forgotPressed() {
        delegate?.forgotButton()
    }
    
    @objc func eyePressed(sender: UIButton) {
        delegate?.eyeButton(sender: sender)
    }
}

extension LoginView: ConfigurationView {
    
    func viewHierarchy() {
        
        addSubview(stackVertical)
        stackVertical.addArrangedSubview(loginLabel)
        stackVertical.addArrangedSubview(blockAndApt)
        stackVertical.addArrangedSubview(passwordLabel)
        stackVertical.addArrangedSubview(passwordTxt)
        addSubview(loginButton)
        addSubview(forgetPass)
        addSubview(creatAccount)
        addSubview(eyeButton)
        
        addSubview(myGit)
        addSubview(seccLabel)
    }
    
    func setConstrants() {
        
        let halfScreen = ((UIScreen.main.bounds.width - 16)/4)*3
        
        stackVertical.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(halfScreen)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(35)
        }
        
        blockAndApt.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(35)
        }

        passwordTxt.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
        }

        eyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTxt.snp.centerY)
            make.leading.equalTo(passwordTxt.snp.trailing).offset(8)
            make.width.equalTo(35)
            make.height.equalTo(passwordTxt.snp.height)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackVertical.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(forgetPass.snp.width)
        }

        forgetPass.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        creatAccount.snp.makeConstraints { make in
            make.top.equalTo(forgetPass.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        myGit.snp.makeConstraints { make in
            make.bottom.equalTo(seccLabel.snp.top)
            make.centerX.equalToSuperview()
        }
        
        seccLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
}
