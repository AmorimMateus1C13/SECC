//
//  CreatLoginView.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//


import UIKit
import SnapKit

protocol CreatLoginViewButtons {
    func creatButton()
}

class CreatLoginView:UIView {
    
    var delegate : CreatLoginViewButtons?
    
    var stackVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        return stack
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Nome"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var nameText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite seu nome"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var surNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Sobrenome"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var surNameText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite seu sobrenome"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var emailLabel: UILabel = {
       let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var emailText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite seu email: "
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var passwordLabel: UILabel = {
       let label = UILabel()
        label.text = "Senha"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var passwordText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite sua senha"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var confirmPasswordLabel: UILabel = {
       let label = UILabel()
        label.text = "Confirme a Senha"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var confirmPasswordText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite sua senha"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var blocklabel: UILabel = {
       let label = UILabel()
        label.text = "Bloco"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var blockText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholder = "Digite seu bloco"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var apartlabel: UILabel = {
       let label = UILabel()
        label.text = "Apartamento"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
//        label.numberOfLines = 0
        return label
    }()
    
    var apartText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 18)
//        text.placeholder = "Digite seu apartamento"
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var buttonToCreat: UIButton = {
        let button = UIButton()
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.backgroundColor = Colors.addInCartBackButton
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(creatButtonPressed), for: .touchUpInside)
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
}

extension CreatLoginView {
    
    @objc func creatButtonPressed() {
        delegate?.creatButton()
    }
}

extension CreatLoginView: ConfigurationView {
    func viewHierarchy() {
        addSubview(stackVertical)
        stackVertical.addArrangedSubview(nameLabel)
        stackVertical.addArrangedSubview(nameText)
        stackVertical.addArrangedSubview(surNameLabel)
        stackVertical.addArrangedSubview(surNameText)
        stackVertical.addArrangedSubview(blocklabel)
        stackVertical.addArrangedSubview(blockText)
        stackVertical.addArrangedSubview(apartlabel)
        stackVertical.addArrangedSubview(apartText)
        stackVertical.addArrangedSubview(emailLabel)
        stackVertical.addArrangedSubview(emailText)
        stackVertical.addArrangedSubview(passwordLabel)
        stackVertical.addArrangedSubview(passwordText)
        stackVertical.addArrangedSubview(confirmPasswordLabel)
        stackVertical.addArrangedSubview(confirmPasswordText)
//        stackVertical.addArrangedSubview(buttonToCreat)
        addSubview(buttonToCreat)
    }
    
    func setConstrants() {
        let halfScreen = (UIScreen.main.bounds.width - 16)/2
        stackVertical.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        nameText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        surNameText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        blockText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        apartText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        emailText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        passwordText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        confirmPasswordText.snp.makeConstraints { make in
            make.width.equalTo(halfScreen)
        }
        
        buttonToCreat.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
}
