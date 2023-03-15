//
//  ViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 16/11/22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    var provider: UsersMockProvider = UsersMockProvider()
    var loginViewModel: LoginViewModel?
    
    init(loginView: LoginView = LoginView(), loginViewModel: LoginViewModel?) {
        self.loginView = loginView
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        loginViewModel?.callMock()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        loginView.emailTxt.delegate = self
        loginView.passwordTxt.delegate = self
        loginViewModel?.callMock()
        loginViewModel?.delegate = self
        addInView()
        makeContrants()
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
        loginView.emailTxt.resignFirstResponder()
        loginView.passwordTxt.resignFirstResponder()
    }
}

extension LoginViewController: ButtonsOfLogin {
    func loginButton(email: String, password: String) {
        
        if let user = loginViewModel?.user, let fooOffSet = user.firstIndex(where: {($0.email) == email && $0.password == password }) {
            guard let currentUser = loginViewModel?.user?[fooOffSet] else { return }
            
            let tabBar = UITabBarController()
            let homeViewModel = HomeViewModel()
            let home = UINavigationController(rootViewController: HomeViewController(homeViewModel: homeViewModel))
            home.title = TitlesOfControllers.tabTitles.homeTitle
            
            let shoppingCarts = UINavigationController(rootViewController: ShoppingCartsViewController())
            shoppingCarts.title = TitlesOfControllers.tabTitles.shoppingTitle
            
            let addPlus = UINavigationController(rootViewController: AddViewController())
            
            let personalInfo = UINavigationController(rootViewController: PersonalInfoViewController(currentUser: currentUser))
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
        } else {
            Alerts.creatAlertCustom(title: "Falha na autenticação", message: "Usuário ou senha inválidos", view: self)
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
    func showAlert() {
        Alerts.creatAlertCustom(title: "Erro", message: "Erro ao carregar informações", view: self)
    }
}
