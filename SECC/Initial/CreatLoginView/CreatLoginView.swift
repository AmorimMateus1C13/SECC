//
//  CreatLoginView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//


import UIKit
import SnapKit

protocol CreatLoginViewButtons {
    func creatButton(userName: String, userSurName: String,userApart: String, userBlock: String, userEmail: String, userPass: String, userConfPass: String)
    func eyeButton(sender: UIButton)
}

class CreatLoginView:UIView {
    
    var delegate : CreatLoginViewButtons?
    
    var contrastView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .clear
        return view
    }()
    
    var registerTitle : UILabel = {
        let label = UILabel()
        label.text = "Registro"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Nome"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    var nameText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        return text
    }()
    
    var surNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Sobrenome"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    var surNameText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        return text
    }()
    
    var blocklabel: UILabel = {
       let label = UILabel()
        label.text = "Bloco"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    var blockText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        text.autocapitalizationType = .none
        return text
    }()
    
    var apartlabel: UILabel = {
       let label = UILabel()
        label.text = "Apartamento"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    var apartText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        text.autocapitalizationType = .none
        return text
    }()
    
    var emailLabel: UILabel = {
       let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var emailText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        text.autocapitalizationType = .none
        return text
    }()
    
    var passwordLabel: UILabel = {
       let label = UILabel()
        label.text = "Senha"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var passwordText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        text.autocapitalizationType = .none
        return text
    }()
    
    var confirmPasswordLabel: UILabel = {
       let label = UILabel()
        label.text = "Confirme a Senha"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var confirmPasswordText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.backgroundColor = .white
        text.layer.cornerRadius = 15
        text.autocorrectionType = .default
        text.autocapitalizationType = .none
        return text
    }()
    
    var buttonToCreat: UIButton = {
        let button = UIButton()
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.backgroundColor = Colors.addInCartBackButton
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(creatButtonPressed), for: .touchUpInside)
        return button
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeEyeButton(button: UIButton, buttonImage: String, isSecureText: Bool) {
        confirmPasswordText.isSecureTextEntry = isSecureText
        passwordText.isSecureTextEntry = isSecureText
        var config = UIImage.SymbolConfiguration(hierarchicalColor: .white)
        config = config.applying(UIImage.SymbolConfiguration(pointSize: 15))
        if let image = UIImage(systemName: buttonImage,withConfiguration: config){
            button.setImage(image, for: .normal)
            button.contentMode = .scaleAspectFill
        }
    }
    
}

extension CreatLoginView {
    
    @objc func creatButtonPressed() {
        guard let userName = nameText.text else { return }
        guard let userSurName = surNameText.text else { return }
        guard let userApart = apartText.text else { return }
        guard let userBlock = blockText.text else { return }
        guard let userEmail = emailText.text else { return }
        guard let userPass = passwordText.text else { return }
        guard let userConfPass = confirmPasswordText.text else { return }
        delegate?.creatButton(userName: userName, userSurName: userSurName, userApart: userApart, userBlock: userBlock, userEmail: userEmail, userPass: userPass, userConfPass: userConfPass)
    }
    
    @objc func eyePressed(sender: UIButton) {
        delegate?.eyeButton(sender: sender)
    }
}

extension CreatLoginView: ConfigurationView {
    func viewHierarchy() {
        addSubview(contrastView)
        contrastView.addSubview(registerTitle)
        
        contrastView.addSubview(nameLabel)
        contrastView.addSubview(surNameLabel)
        
        contrastView.addSubview(nameText)
        contrastView.addSubview(surNameText)
        
        contrastView.addSubview(blocklabel)
        contrastView.addSubview(apartlabel)
        
        contrastView.addSubview(blockText)
        contrastView.addSubview(apartText)
        
        contrastView.addSubview(emailLabel)
        contrastView.addSubview(emailText)
        
        contrastView.addSubview(passwordLabel)
        contrastView.addSubview(passwordText)
        
        contrastView.addSubview(confirmPasswordLabel)
        contrastView.addSubview(confirmPasswordText)
        
        contrastView.addSubview(buttonToCreat)
    }
    
    func setConstrants() {
        let halfScreen = (UIScreen.main.bounds.width - 16)/2
        let widthText = (((UIScreen.main.bounds.width - 32) / 4) * 3)
        
        contrastView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registerTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(registerTitle.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(35)
            make.width.equalTo(halfScreen - 24)
        }
        
        surNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
        }
        
        nameText.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(halfScreen - 24)
            make.height.equalTo(nameLabel.snp.height)
        }

        surNameText.snp.makeConstraints { make in
            make.centerY.equalTo(nameText.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(nameText.snp.trailing).offset(8)
            make.height.equalTo(nameText.snp.height)
        }
        
        blocklabel.snp.makeConstraints { make in
            make.top.equalTo(nameText.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(halfScreen - 24)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        apartlabel.snp.makeConstraints { make in
            make.centerY.equalTo(blocklabel.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(blocklabel.snp.trailing).offset(8)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        blockText.snp.makeConstraints { make in
            make.top.equalTo(blocklabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(halfScreen - 24)
            make.height.equalTo(blocklabel.snp.height)
        }
        
        apartText.snp.makeConstraints { make in
            make.centerY.equalTo(blockText.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(blockText.snp.trailing).offset(8)
            make.height.equalTo(blockText.snp.height)
        }
        
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(blockText.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        emailText.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(emailLabel.snp.height)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailText.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        passwordText.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(widthText)
            make.height.equalTo(passwordLabel.snp.height)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordText.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        confirmPasswordText.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(widthText)
            make.height.equalTo(confirmPasswordLabel.snp.height)
        }

        buttonToCreat.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(35)
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
}
