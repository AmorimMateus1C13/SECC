//
//  FormView.swift
//  SECC
//
//  Created by Mateus Amorim on 15/12/22.
//

import UIKit
import SnapKit

protocol FormViewButtonsAction {
    func registerAction(productTitle: String, productValue: String)
}

class FormView: UIView {

    var delegate: FormViewButtonsAction?
    
    lazy var charLimited = 500
    lazy var charTyped = 0
    
    var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .fill
        stack.backgroundColor = .systemFill
        return stack
    }()
    
    var productName: UILabel = {
        let label = UILabel()
        label.text = AddMock.nameTitle
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var productNameText: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        return text
    }()
    
    var productValue: UILabel = {
        let label = UILabel()
        label.text = AddMock.valueTitle
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var stackViewHorizontal1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    var signMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "R$:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    var productValueText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 14)
        text.placeholder = "Ex: 0,00"
        text.backgroundColor = .clear
        text.keyboardType = .numbersAndPunctuation
        return text
    }()
    
    var productDescripton: UILabel = {
        let label = UILabel()
        label.text = AddMock.descriptionTitle
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var productDescriptionText: UITextView = {
        let text = UITextView()
        text.backgroundColor = .white
        text.textAlignment = .justified
        text.font = UIFont.systemFont(ofSize: 14)
        text.isScrollEnabled = true
        text.layer.cornerRadius = 5
        
        return text
    }()
    
    var numberOfCharLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    var stackViewHorizontal2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
 
    var blocLabel: UILabel = {
        let label = UILabel()
        label.text = "Bloco:"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var aptLabel: UILabel = {
        let label = UILabel()
        label.text = "Apartamento:"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var stackViewHorizontal3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    var blockTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Selecionar"
        text.textAlignment = .center
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 3
        text.layer.borderColor = Colors.borderButtons
        text.textColor = Colors.DetailView.buyBackButton
        return text
    }()
    
    var blockPickview: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 1
        picker.backgroundColor = .white
        return picker
    }()
    
    var aptTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Selecionar"
        text.textAlignment = .center
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 3
        text.layer.borderColor = Colors.borderButtons
        text.textColor = Colors.DetailView.buyBackButton
        return text
    }()
    
    var aptPickview: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.tag = 2
        return picker
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.backgroundColor = Colors.DetailView.addInCartBackButton
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonRegisterPressed), for: .touchUpInside)
        return button
    }()
    
    var viewfake: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        productDescriptionText.delegate = self
        numberOfCharLabel.text = "\(charTyped)/\(charLimited)"
        
        productNameText.delegate = self
        productValueText.delegate = self
        
        aptPickview.delegate = self
        blockPickview.delegate = self
        
        aptTextField.inputView = aptPickview
        blockTextField.inputView = blockPickview
        
        addDoneButtonOnKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FormView {
    @objc func buttonRegisterPressed() {
        guard let productName = productNameText.text else { return }
        guard let productValue = productValueText.text else { return }

        delegate?.registerAction(productTitle: productName, productValue: productValue)
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Concluído", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        productDescriptionText.inputAccessoryView = doneToolbar
        productValueText.inputAccessoryView = doneToolbar
        productNameText.inputAccessoryView = doneToolbar
        blockTextField.inputAccessoryView = doneToolbar
        aptTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            productDescriptionText.resignFirstResponder()
            productNameText.resignFirstResponder()
            productValueText.resignFirstResponder()
            blockTextField.resignFirstResponder()
            aptTextField.resignFirstResponder()
        }
}

extension FormView: ConfigurationView {
    func viewHierarchy() {
        addSubview(stackViewVertical)
        
        stackViewVertical.addArrangedSubview(productName)
        stackViewVertical.addArrangedSubview(productNameText)
        stackViewVertical.addArrangedSubview(productValue)
        
        stackViewVertical.addArrangedSubview(stackViewHorizontal1)
        stackViewHorizontal1.addArrangedSubview(signMoneyLabel)
        stackViewHorizontal1.addArrangedSubview(productValueText)
        
        stackViewVertical.addArrangedSubview(productDescripton)
        stackViewVertical.addArrangedSubview(productDescriptionText)
        addSubview(numberOfCharLabel)
        
        stackViewVertical.addArrangedSubview(stackViewHorizontal2)
        stackViewHorizontal2.addArrangedSubview(blocLabel)
        stackViewHorizontal2.addArrangedSubview(aptLabel)
        
        stackViewVertical.addArrangedSubview(stackViewHorizontal3)
        stackViewHorizontal3.addArrangedSubview(blockTextField)
        stackViewHorizontal3.addArrangedSubview(aptTextField)
        
        stackViewVertical.addArrangedSubview(registerButton)
        stackViewVertical.addArrangedSubview(viewfake)
    }
    
    func setConstrants() {
        
        stackViewVertical.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.leading.bottom.equalToSuperview()
        }

        productName.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        productNameText.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }

        productValue.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }

        stackViewHorizontal1.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        signMoneyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        productValueText.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }

        productDescripton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }

        productDescriptionText.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(250)
        }
        
        numberOfCharLabel.snp.makeConstraints { make in
            make.bottom.equalTo(productDescriptionText.snp.bottom)
            make.trailing.equalTo(productDescriptionText.snp.trailing)
            make.height.equalTo(40)
            make.width.equalTo(75)
        }
        
        stackViewHorizontal2.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        blocLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        aptLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        stackViewHorizontal3.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        blockTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(30)
        }
        
        aptTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        
        viewfake.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
}

//MARK: - TextView

extension FormView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        charTyped = numberOfChars
        numberOfCharLabel.text = "\(charTyped)/\(charLimited)"
        return numberOfChars < charLimited 
    }
}

//MARK: - PickerView
extension FormView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return ItemsMock.apt.allBloc.count
        case 2:
            return ItemsMock.apt.allapt.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return ItemsMock.apt.allBloc[row]
        case 2:
            return ItemsMock.apt.allapt[row]
        default:
            return "Data not Found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch pickerView.tag {
        case 1:
            blockTextField.text = ItemsMock.apt.allBloc[row]
        case 2:
            aptTextField.text = ItemsMock.apt.allapt[row]
        default:
            break
        }
    }
}

//MARK: - TextField
extension FormView: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        productNameText.resignFirstResponder()
        productValueText.resignFirstResponder()
        productDescriptionText.resignFirstResponder()
        super.touchesBegan(touches, with: event)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        productNameText.resignFirstResponder()
        productValueText.resignFirstResponder()
        return true
    }
}
