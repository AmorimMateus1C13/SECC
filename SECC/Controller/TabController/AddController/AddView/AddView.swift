//
//  AddView.swift
//  SECC
//
//  Created by Mateus Amorim on 13/12/22.
//

import UIKit
import SnapKit

protocol ButtonActions {
    func cameraOn()
    func searchPhotos()
    func categoryChoice()
//    func registerAction()
}

class AddView: UIView {
    
    var delegate: ButtonActions?
    
    var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .fill
        stack.backgroundColor = .systemFill
        return stack
    }()

    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = AddMock.titleLabel
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        return label
    }()
    
    var productImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        return image
    }()
    
    var stackViewHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 16
        stack.alignment = .fill
        return stack
    }()
    
    var buttonCamera:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = Colors.DetailView.addInCartBackButton
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = Colors.borderButtons
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonCameraPressed), for: .touchUpInside)
        return button
    }()
    
    var buttonPhotos: UIButton = {
        let button = UIButton()
        button.setTitle("Escolher(.png, .jpeg)", for: .normal)
        button.setTitleColor(Colors.DetailView.buyBackButton, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = Colors.borderButtons
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonSearchPressed), for: .touchUpInside)
        return button
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Escolha uma Categoria"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AddMock.categoryTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(Colors.DetailView.buyBackButton, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = Colors.borderButtons
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(categoryButtonpressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddView: ConfigurationView {
    func viewHierarchy() {
        
        addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(titleLabel)
        stackViewVertical.addArrangedSubview(productImage)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        
        stackViewHorizontal.addArrangedSubview(buttonCamera)
        stackViewHorizontal.addArrangedSubview(buttonPhotos)
        
        stackViewVertical.addArrangedSubview(categoryLabel)
        stackViewVertical.addArrangedSubview(categoryButton)
    }
    
    func setConstrants() {
        
        stackViewVertical.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImage.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(200)
        }
        
        stackViewHorizontal.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
        
        buttonCamera.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(75)
        }
        
        buttonPhotos.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(buttonCamera.snp.height)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        categoryButton.snp.makeConstraints { make in            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }
}

extension AddView {
    @objc func buttonCameraPressed() {
        delegate?.cameraOn()
    }
    
    @objc func buttonSearchPressed() {
        delegate?.searchPhotos()
    }
    
    @objc func categoryButtonpressed(_ sender: UIButton) {
        delegate?.categoryChoice()
    }
}
