//
//  ViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import UIKit
import SnapKit
import FirebaseDatabase
import Firebase

class LoginViewController: UIViewController {
    
    var database = Database.database().reference()
    var handle: DatabaseHandle?
    var loginView = LoginView()
    var loginViewModel: LoginViewModel?
    var eye: Bool = Bool()
    
    init(loginView: LoginView = LoginView(), loginViewModel: LoginViewModel? = LoginViewModel()) {
        self.loginView = loginView
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        loginView.blockAndApt.delegate = self
        loginView.passwordTxt.delegate = self
        loginViewModel?.delegate = self
        addInView()
        makeContrants()
    }
    
    func isEmpty(text: String, textField: UITextField) -> Bool {
        if text.isEmpty {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(ciColor: .red).cgColor
            return true
        } else {
            return false
        }
    }
    
    enum TextEmpty {
        case blockAndApt
        case password
        case all
    }
    
    func verifyEmptyInText(rules: TextEmpty, blockAnApt: String, passSafe: String) -> Bool {
        switch rules {
        case .blockAndApt:
            return isEmpty(text: blockAnApt, textField: loginView.blockAndApt)
        case .password:
            return isEmpty(text: passSafe, textField: loginView.passwordTxt)
        case .all:
            if isEmpty(text: blockAnApt, textField: loginView.blockAndApt) && isEmpty(text: passSafe, textField: loginView.passwordTxt) {
                return true
            } else {
                return false
            }
        }
    }
    
    func creatTabBarController(userIndentifier: String) {
            let tabBar = UITabBarController()
            
        let home = UINavigationController(rootViewController: HomeViewController(userIndentifier: userIndentifier))
            home.title = TitlesOfControllers.tabTitles.homeTitle
            
        let shoppingCarts = UINavigationController(rootViewController: ShoppingCartsViewController( titleShopp: TitlesOfControllers.tabTitles.shoppingTitle, userIndentifier: userIndentifier))
            shoppingCarts.title = TitlesOfControllers.tabTitles.shoppingTitle
            
            let addPlus = UINavigationController(rootViewController: AddViewController())
            
        let personalInfo = UINavigationController(rootViewController: PersonalInfoViewController(userIdentifier: userIndentifier))
            personalInfo.title = TitlesOfControllers.tabTitles.personalTitle
            
            let configView =  UINavigationController(rootViewController: ConfigViewController())
            configView.title = TitlesOfControllers.tabTitles.configTitle
            
            tabBar.setViewControllers([home, shoppingCarts, addPlus , personalInfo, configView], animated: true)
            
            tabBar.tabBar.backgroundColor = .systemBackground
            navigationController?.navigationBar.backgroundColor = .systemBackground
            
            guard let item = tabBar.tabBar.items else {
                return
            }
            
            let image = ["house", "cart", "plus" ,"person", "gearshape"]
            
            for x in 0..<item.count {
                item[x].image = UIImage(systemName: image[x])
            }
            
            tabBar.modalPresentationStyle = .fullScreen
            present(tabBar,animated: true)
       
    }
}

// MARK: - Contrants
 
extension LoginViewController {
    
    func addInView() {
        view.addSubview(loginView)
    }
    
    func makeContrants() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - TextField Configuration

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView.blockAndApt.resignFirstResponder()
        loginView.passwordTxt.resignFirstResponder()
    }
    
}

extension LoginViewController: ButtonsOfLogin {
    
    func eyeButton(sender: UIButton) {
        eye = !eye
        if eye {
            loginView.changeEyeButton(
                button: sender,
                buttonImage: "eye.slash",
                isSecureText: !eye)
        }else {
            loginView.changeEyeButton(
                button: sender,
                buttonImage: "eye",
                isSecureText: !eye)
        }

    }
    
    
    func loginButton(blockAnApt: String, password: String) {
                
        if !verifyEmptyInText(rules: .all, blockAnApt: blockAnApt, passSafe: password) {
            var textempty = 0
            if verifyEmptyInText(rules: .blockAndApt, blockAnApt: blockAnApt, passSafe: password) {
                textempty += 1
            }
            
            if verifyEmptyInText(rules: .password, blockAnApt: blockAnApt, passSafe: password) {
                textempty += 1
            }
            
            if textempty == 0 {
                loginViewModel?.getUserFromFirebase(blockAndApat: blockAnApt, userPassword: password)
            }
        }
    }
    
    func forgotButton() {
        let vc = ForgetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func creatButton() {
        let vc = CreatLoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: LoginViewModelProtocol {
    
    func emailDifferenceInEmail() {
        Alerts.creatAlertCustom(title: "Erro", message: "Erro ao carregar informações", view: self)
    }
    
    func emailDontExist() {
        Alerts.creatAlertCustom(title: "Falha na autenticação", message: "email não existe", view: self)
    }
    
    
    func callTabBarController(userIndentifier: String) {
        creatTabBarController(userIndentifier: userIndentifier)
    }
}
