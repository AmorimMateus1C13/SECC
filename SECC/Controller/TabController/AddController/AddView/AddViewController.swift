//
//  AddViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 25/11/22.
//

import UIKit
import SnapKit
import PhotosUI
import Photos

class AddViewController: UIViewController {
    
    var addView = AddView()
    var formView = FormView()
    
    let transparentView = UIView()
    var selectedButton = UIButton()
    
    
    var scrollViewVertical: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    var tableViewList: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(ListCategoryCell.self, forCellReuseIdentifier: ListCategoryCell.identifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        navigationController?.navigationBar.isHidden = true
        addInView()
        makeConstrants()
        addView.delegate = self
        formView.delegate = self
        tableViewList.delegate = self
        tableViewList.dataSource = self
    }
    
    func addAlert(title: String, message: String, buttonTittle: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: buttonTittle, style: .cancel)
        ac.addAction(alert)
        present(ac, animated: true)
    }
    
    func reloadView() {
        addView.productImage.image = nil
        addView.categoryButton.setTitle(AddMock.categoryTitle, for: .normal)
        formView.productNameText.text = nil
        formView.productValueText.text = nil
        formView.productDescriptionText.text = nil
        formView.charTyped = 0
        formView.numberOfCharLabel.text = "\(formView.charTyped)/\(formView.charLimited)"
        formView.blockTextField.text = nil
        formView.aptTextField.text = nil
        viewDidLoad()
    }
}

extension AddViewController {
    func addInView() {
        view.addSubview(scrollViewVertical)
        scrollViewVertical.addSubview(addView)
        scrollViewVertical.addSubview(formView)
    }
    
    func makeConstrants() {
        scrollViewVertical.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaInsets)
        }
        
        addView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo((view.frame.height / 2) - 40)
            make.width.equalTo(scrollViewVertical.snp.width)
        }
        
        formView.snp.makeConstraints { make in
            make.top.equalTo(addView.snp.bottom).inset(8)
            make.trailing.leading.bottom.equalToSuperview()
            make.width.equalTo(scrollViewVertical.snp.width)
        }
    }
}

extension AddViewController: ButtonActions {
    
    func searchPhotos() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter =  .images
        
        let pickerController = PHPickerViewController(configuration: config)
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    
    func cameraOn() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func categoryChoice() {
        addTransparentView(frames: addView.categoryButton.frame)
        selectedButton =  addView.categoryButton
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion:  nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        addView.productImage.image = image
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self.addView.productImage.image = image
                }
            }
        }
    }
}

extension AddViewController {
    
    func addTransparentView(frames: CGRect) {
        
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableViewList.frame =  CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(tableViewList)
        tableViewList.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tableViewList.reloadData()
        tableViewList.alpha = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 1
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 1
            self.tableViewList.frame =  CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(ItemsMock.category.titles.count * 20))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewList.frame =  CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}


extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsMock.category.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCategoryCell.identifier, for: indexPath) as? ListCategoryCell
        cell?.listaLabel.text = ItemsMock.category.titles[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(ItemsMock.category.titles[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

extension AddViewController: FormViewButtonsAction {
    
    func registerAction(productTitle: String, productValue: String) {
        if productTitle == ""{
            addAlert(title: "", message: "Necessário atribuir um Título", buttonTittle: "OK")
        }
        
        if productValue == ""  {
            addAlert(title: "", message: "Necessário atribuir um Valor", buttonTittle: "OK")
        }
        
        guard let productImage = addView.productImage.image else {
            addAlert(title: "", message: "Necessário atribuir Imagem", buttonTittle: "OK")
            return }
        
        guard let category = selectedButton.currentTitle else {
            addAlert(title: "", message: "Necessário atribuir uma Categoria", buttonTittle: "OK")
            return }
        
        switch category {
        case "Ferramentas":
            ItemsMock.tools.toolTitle.append(productTitle)
            ItemsMock.tools.itemImage.append(productImage)
            ItemsMock.tools.toolValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Produto adicionado ao catálago.", buttonTittle: "OK!")
            reloadView()
        case "Apartamentos":
            ItemsMock.apt.aptTitle.append(productTitle)
            ItemsMock.apt.aptImage.append(productImage)
            ItemsMock.apt.aptValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Apartamento adicionado ao catálago.", buttonTittle: "OK!")
            reloadView()
        case "Recreação":
            ItemsMock.recreation.recreationTitle.append(productTitle)
            ItemsMock.recreation.recreationImage.append(productImage)
            ItemsMock.recreation.recreationValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Recreação adicionado ao catálago.", buttonTittle: "OK!")
            reloadView()
        case "Salão de Festa":
            ItemsMock.partyRoom.partyRoomTitle.append(productTitle)
            ItemsMock.partyRoom.partyRoomImage.append(productImage)
            ItemsMock.partyRoom.partyRoomValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Salão de Festas adicionado ao catálago.", buttonTittle: "OK!")
            reloadView()
        case "Serviços":
            ItemsMock.services.servicesTitle.append(productTitle)
            ItemsMock.services.servicesImage.append(productImage)
            ItemsMock.services.servicesValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Serviço adicionado ao catálago.", buttonTittle: "OK!")
            reloadView()
        case "Estacionamento":
            ItemsMock.parking.parkingTitle.append(productTitle)
            ItemsMock.parking.parkingImage.append(productImage)
            ItemsMock.parking.parkingValues.append(productValue)
            addAlert(title: "Sucesso!", message: "Vaga adicionada ao catálago.", buttonTittle: "OK!")
            reloadView()
        default:
            break
        }
    }
}
