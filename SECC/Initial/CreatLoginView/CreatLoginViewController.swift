//
//  CreatLoginViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit
import FirebaseDatabase

class CreatLoginViewController: UIViewController {
    
    var creatLoginView = CreatLoginView()
    var eye: Bool = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        addInView()
        makeConstrants()
        creatLoginView.delegate = self
        creatLoginView.emailText.delegate = self
        creatLoginView.passwordText.delegate = self
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.backButtonTitle = "Voltar"
        navigationController?.isNavigationBarHidden = false
        
    }
    
    func rulesAcepted() -> Bool {
        var rulePass = 0
        if let userName = creatLoginView.nameText.text {
            if !isEmpty(text: userName, textField: creatLoginView.nameText) {
                rulePass += 1
            }
        }
        
        if let userSurName = creatLoginView.surNameText.text {
            if !isEmpty(text: userSurName, textField: creatLoginView.surNameText) {
                rulePass += 1
            }
        }
        
        if let userApart = creatLoginView.apartText.text {
            if !isEmpty(text: userApart, textField: creatLoginView.apartText) {
                rulePass += 1
            }
        }
       
        if let userBlock = creatLoginView.blockText.text {
            if !isEmpty(text: userBlock, textField: creatLoginView.blockText) {
                rulePass += 1
            }
        }
        
        if let userEmail = creatLoginView.emailText.text {
            if !isEmpty(text: userEmail, textField: creatLoginView.emailText) {
                rulePass += 1
            }
        }
        
        if let userPass = creatLoginView.passwordText.text {
            if !isEmpty(text: userPass, textField: creatLoginView.passwordText) {
                rulePass += 1
            }
        }
        
        if let userConfPass = creatLoginView.confirmPasswordText.text {
            if !isEmpty(text: userConfPass, textField: creatLoginView.confirmPasswordText) {
                rulePass += 1
            }
        }
        
        if rulePass == 7 {
            return true
        } else {
            return false
        }
        
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
    
    enum RulesOfPassword {
        case maxLengthm
        case lowerLetter
        case charSpecial
        case capLetter
    }
    
    func maxLengthmRule(password: String) -> Bool {
        if password.count < 8 {
            Alerts.creatAlertCustom(
                title: "Número de Caracteres",
                message: "O número de caracteres deve ser de no minimo 8.",
                view: self)
            return false
        } else {
            return true
        }
    }
    
    func lowerLetterRule(password: String) -> Bool {
        var loewrqt = 0
        let lowers = CharacterSet.lowercaseLetters
        password.unicodeScalars.forEach {
            if lowers.contains($0)  {
                loewrqt += 1
            } else {
                loewrqt += 0
            }
        }
        
        if loewrqt > 0 {
            return true
        }else {
            Alerts.creatAlertCustom(
                title: "Letra maiuscula",
                message: "Necessario",
                view: self)
            return false
        }
    }
    
    func charSpecialRule(password: String) -> Bool {
        if password.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil {
            return true
        } else {
            Alerts.creatAlertCustom(
                title: "Caractere Especial",
                message: "Necessário",
                view: self)
            return false
        }
    }
    
    func capitalizedLetterRule(password: String) -> Bool {
        var numCap = 0
        for chr in password {
            let str = String(chr)
            if str.lowercased() != str {
                numCap += 1
            }
        }
        
        if numCap > 0 {
            return true
        } else {
            Alerts.creatAlertCustom(
                title: "Letra Maiuscula",
                message: "Necessária",
                view: self)
            return false
        }
    }
    
    func passRules(rules: RulesOfPassword, password: String) -> Bool {
        switch rules {
        case .maxLengthm:
            return maxLengthmRule(password: password)
        case .lowerLetter:
            return lowerLetterRule(password: password)
        case.charSpecial:
            return charSpecialRule(password: password)
        case .capLetter:
           return capitalizedLetterRule(password: password)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func comparePass(password: String, confirPass: String)-> Bool {
        if password == confirPass {
            return true
        }else {
            return false
        }
    }
    
    func rulesToCreatUser(userEmail: String, userPass: String, userConfPass: String)-> Bool {
        if rulesAcepted() {
            var internalRulesAcept = 0
            if isValidEmail(email: userEmail){
                internalRulesAcept += 1
            }
            if passRules(rules: .maxLengthm, password: userPass) {
                internalRulesAcept += 1
            }
            
            if passRules(rules: .capLetter, password: userPass) {
                internalRulesAcept += 1
            }
            if passRules(rules: .charSpecial, password: userPass) {
                internalRulesAcept += 1
            }
            if passRules(rules: .lowerLetter, password: userPass) {
                internalRulesAcept += 1
            }
            
            if comparePass(password: userPass, confirPass: userConfPass) {
                internalRulesAcept += 1
            }
            
            if internalRulesAcept == 6 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}


//MARK: - Add In View
extension CreatLoginViewController {
    
    func addInView() {
        view.addSubview(creatLoginView)
    }
    
    func makeConstrants() {
        creatLoginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CreatLoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        creatLoginView.emailText.resignFirstResponder()
        creatLoginView.passwordText.resignFirstResponder()
    }
}

extension CreatLoginViewController: CreatLoginViewButtons {
    
    func eyeButton(sender: UIButton) {
        eye = !eye
        if eye {
            creatLoginView.changeEyeButton(
                button: sender,
                buttonImage: "eye.slash",
                isSecureText: !eye)
        }else {
            creatLoginView.changeEyeButton(
                button: sender,
                buttonImage: "eye",
                isSecureText: !eye)
        }
    }
    
    func creatButton(userName: String, userSurName: String,userApart: String, userBlock: String, userEmail: String, userPass: String, userConfPass: String)  {
   
        if rulesToCreatUser(userEmail: userEmail, userPass: userPass, userConfPass: userConfPass) {
            let userIdentifier = userBlock+userApart
            
            let ref = Database.database().reference()

            let shoppingCart: [String: Any] = [
                "itemName": "" as NSObject,
                "itemPrice": "",
                "itemDetail": "",
                "itemImageArray": ""
            ]

            let userId: [String: Any] = [
                "email": "\(userEmail)" as NSObject,
                "password": "\(userPass)",
                "userName": "\(userName)",
                "userSurName": "\(userSurName)",
                "userBlock": "\(userBlock)",
                "userApart": "\(userApart)"
            ]

            ref.child("Users").child("\(userIdentifier)").child(DataObject.rootShoppingCart).child("0").setValue(shoppingCart)
            ref.child("Users").child("\(userIdentifier)").child("userId").setValue(userId)
            Alerts.creatAlertCustom(title: "Conta criada", message: "Sua conta foi criada com sucesso!", view: self)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
