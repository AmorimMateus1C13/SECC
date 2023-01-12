//
//  DetailsItemViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit

class DetailsItemViewController: UIViewController {
    
    var titleOfItem: String
    
    var imageItem: UIImage
    
    var detailItem: String
    
    var valueItem: String
    
    var titleLabel: String
    
   var detailsView = DetailsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setupConfiguration()
        }
        
        view.backgroundColor = .clear
        detailsView.delegate = self
        navigationController?.navigationBar.topItem?.backButtonTitle = titleLabel

    }
    
    init(titleOfItem: String, imageOfItem: UIImage, detailOfItem: String, valueOfItem: String, titleLabel: String) {
        
        self.titleOfItem = titleOfItem
        self.detailItem = detailOfItem
        self.imageItem =  imageOfItem
        self.valueItem = valueOfItem
        self.titleLabel = titleLabel
        super.init(nibName: nil, bundle: nil)
        
        DispatchQueue.main.async {
            self.detailsView.setView(imageName: self.imageItem, valueItem: "\(self.valueItem)", detail: self.detailItem, title: self.titleOfItem)
        }
            }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsItemViewController: ConfigurationView {
    
    func viewHierarchy() {
        view.addSubview(detailsView)
    }
    
    func setConstrants() {
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DetailsItemViewController: ButtonsActions {
    
    func buyItem() {
        let vc = BuyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addInCart(itemText: String, valueItem: String, imageItem: UIImage, detailItem: String) {
        if ShoppingItemsCart.itemsTitle.contains(itemText) {
            let ac = UIAlertController(title: "Atenção", message: "Esse item já foi adicionado ao carrinho.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        } else {
            ShoppingItemsCart.itemsTitle.append(itemText)
            ShoppingItemsCart.valuesItems.append(valueItem)
            ShoppingItemsCart.imagesItems.append(imageItem)
            ShoppingItemsCart.detailItems.append(detailItem)
        }
    }
}
