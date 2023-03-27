//
//  DetailsItemViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit
import FirebaseDatabase

class DetailsItemViewController: UIViewController {
        
    var detailsViewModel: DetailsViewModel?
    var detailsView = DetailsView()
    var categoryName: String = String()
    var objectName: String = String()
    var objectPrice: String = String()
    var currentcategoryId: Int = Int()
    var currentObjectId: Int = Int()
    var objectImagesArray: [String] = []
    var amountOfImages: Int = Int()
    var objectDetail: String = String()
    var userIndentifier: String = String()
    var shoppBackbutton: String = String()
 
    init(shoppBackbutton: String = String(),categoryName: String, objectName: String = String(), currentcategoryId: Int, currentObjectId: Int, objectPrice: String, detailsViewModel: DetailsViewModel? = DetailsViewModel(), userIndentifier: String ) {
        super.init(nibName: nil, bundle: nil)
        self.categoryName = categoryName
        self.detailsViewModel = detailsViewModel
        self.currentcategoryId = currentcategoryId
        self.currentObjectId = currentObjectId
        self.objectName = objectName
        self.objectPrice = objectPrice
        self.userIndentifier = userIndentifier
        self.shoppBackbutton = shoppBackbutton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        detailsView.delegate = self
        detailsView.collectionView.delegate = self
        detailsView.collectionView.dataSource = self
        detailsViewModel?.delegate = self
        detailsViewModel?.getAmountOfImages(categoryId: currentcategoryId, objectId: currentObjectId)
        setViewinformations()
        if shoppBackbutton == String() {
            navigationController?.navigationBar.topItem?.backButtonTitle = categoryName
        } else {
            navigationController?.navigationBar.topItem?.backButtonTitle = shoppBackbutton
        }
        
    }
    
    func setViewinformations() {
        if objectImagesArray != [] {
            detailsView.setView(itemsCollectionImages: objectImagesArray, valueItem: objectPrice, detail: objectDetail, title: objectName)
        }
    }
    
    func addInFirebase(itemsArray: Int) {
        let ref = Database.database().reference()
        
            let itemCart: [String: Any] = [
                "categoryName": "\(self.categoryName)" as NSObject,
                "categoryId": "\(self.currentcategoryId)",
                "itemName": "\(self.objectName)",
                "itemPrice": "\(self.objectPrice)",
                "itemDetail": "\(self.objectDetail)",
                "itemImage": "\(self.objectImagesArray[0])"
            ]

        ref.child("Users").child("\(userIndentifier)").child(DataObject.rootShoppingCart).child("\(itemsArray)").setValue(itemCart)
    }
    
    
    func objectExistInShoppCart(itemsInShoppCart: Int){
        let ref = Database.database().reference()
        var noExist = 0
        var itemExist = 0
        for i in 0..<itemsInShoppCart {
            ref.child("Users").child("\(self.userIndentifier)").child(DataObject.rootShoppingCart).child("\(i)").child(DataObject.itemName).observeSingleEvent(of: .value) { DataSnapshot in
                guard let name = DataSnapshot.value as? String else { return }
                if self.objectName != name {
                    noExist += 1
                } else {
                    itemExist = 1
                }
                if noExist == itemsInShoppCart {
                    ref.child("Users").child("\(self.userIndentifier)").child(DataObject.rootShoppingCart).child("0").child(DataObject.itemName).observeSingleEvent(of: .value) { DataSnapshot in
                        guard let name = DataSnapshot.value as? String else { return }
                        if name == "" {
                            self.addInFirebase(itemsArray: itemsInShoppCart - 1)
                        } else {
                            self.addInFirebase(itemsArray: itemsInShoppCart)
                        }
                    }
                }
                if itemExist == 1 {
                    Alerts.creatAlertCustom(title: "O item já existente no carrinho", message: "Não é possível adicionar o mesmo itens 2 vezes", view: self)
                }
            }
        }
        
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

extension DetailsItemViewController: DetailsViewModelProtocol {
    
    func getObjectsImagesArray(objectimage: String) {
        self.objectImagesArray.append(objectimage)
        setViewinformations()
        detailsView.collectionView.reloadData()
    }
    
    func getAmountOfImages(amountOfImages: Int) {
        self.amountOfImages = amountOfImages
        setViewinformations()
        detailsView.collectionView.reloadData()
    }
    
    func getObjectDetail(detail: String) {
        self.objectDetail = detail
        setViewinformations()
        detailsView.collectionView.reloadData()
    }
}

extension DetailsItemViewController: ButtonsActions {
    
    func addInCart() {
        let ref = Database.database().reference()
        ref.child("Users").child("\(userIndentifier)").child(DataObject.rootShoppingCart).observeSingleEvent(of: .value) { DataSnapshot in
            guard let items = DataSnapshot.value as? [Any] else {
                print("Não funcionou")
                return }
             self.objectExistInShoppCart(itemsInShoppCart: items.count)
        }
    }
    
    func buyItem() {
        let vc = BuyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailsItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsView.pageControl.numberOfPages = objectImagesArray.count
        return objectImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesItemsCollectionViewCell.identifier, for: indexPath) as? ImagesItemsCollectionViewCell
        cell?.changeImage(image: objectImagesArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsItemViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(detailsView.collectionView.contentOffset.x / UIScreen.main.bounds.width)
            detailsView.pageControl.currentPage = Int(pageIndex)
    }
}
