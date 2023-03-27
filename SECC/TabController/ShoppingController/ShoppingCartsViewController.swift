//
//  ShoppingCartsViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 18/11/22.
//

import UIKit
import SnapKit
import SwipeCellKit

class ShoppingCartsViewController: UIViewController {
    
    var shopEmptyView = ShopEmptyView()
    var shopCollectionView = ShopCollectionView()
    
    var shoppingViewModel: ShoppingViewModel?
    var categoryName: [String] = []
    var categoryId: [Int] = []
    var amountOfItems: Int = Int()
    var itemName: [String] = []
    var itemPrice: [String] = []
    var itemImage: [String] = []
    var indexPathDelete = IndexPath()
    var userIndentifier: String = String()
    var titleShopp: String = String()
    
    init(titleShopp: String = String(),shoppingViewModel: ShoppingViewModel? = ShoppingViewModel(), userIndentifier: String) {
        self.shoppingViewModel = shoppingViewModel
        self.userIndentifier = userIndentifier
        self.titleShopp = titleShopp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemName = []
        itemImage = []
        itemPrice = []
        shoppingViewModel?.delegate = self
        shoppingViewModel?.getShoppingCartData(userIndentifier: userIndentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingViewModel?.delegate = self
        view.backgroundColor = Colors.LoginView.backgroundView
        shopCollectionView.collectionView.delegate = self
        shopCollectionView.collectionView.dataSource = self
        if amountOfItems == 0 {
            addInView()
            makeConstrants()
        }
    }
}

extension ShoppingCartsViewController: ShoppingViewModelProtocol {
    func getCategoryName(currentCategory: String) {
        self.categoryName.append(currentCategory)
        shopCollectionView.collectionView.reloadData()
    }
    
    func getCategoryId(currentId: Int) {
        self.categoryId.append(currentId)
        shopCollectionView.collectionView.reloadData()
    }
    
    func callViewEmpty() {
        amountOfItems = 0
        addInView()
        makeConstrants()
    }
    
    func addCollectionViewInView() {
        amountOfItems = 1
        addInView()
        makeConstrants()
        shopCollectionView.collectionView.reloadData()
    }
    
    func getItemName(itemName: String) {
        self.itemName.append(itemName)
        shopCollectionView.collectionView.reloadData()
    }
    
    func getItemImage(itemImage: String) {
        self.itemImage.append(itemImage)
        shopCollectionView.collectionView.reloadData()
    }
    
    func getItemPrice(itemPrice: String) {
        self.itemPrice.append(itemPrice)
        shopCollectionView.collectionView.reloadData()
    }
    
    func getAmountOfSHoppingItems(items: Int) {
        self.amountOfItems = items
        
        addInView()
        makeConstrants()
        shopCollectionView.collectionView.reloadData()
    }
}

extension ShoppingCartsViewController {
    
    func addInView() {
        if amountOfItems == 0 {
            view.addSubview(shopEmptyView)
        }else {
            shopEmptyView.removeFromSuperview()
            view.addSubview(shopCollectionView)
        }
    }
    
    func makeConstrants() {
        if amountOfItems == 0 {
            shopEmptyView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            shopCollectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
        }
    }
}

extension ShoppingCartsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amountOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        indexPathDelete = indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCell.identifier, for: indexPath) as? ShoppingCell
 
        if itemName != [] && itemImage != [] && itemPrice != [] {
            cell?.configCell(titleOfCell: itemName[indexPath.row], imageOfCell: itemImage[indexPath.row], productOfValue: itemPrice[indexPath.row])
            cell?.delegate = self
            cell?.buttonDelete.tag = indexPath.row
        }

        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailsItemViewController(shoppBackbutton: titleShopp, categoryName: categoryName[indexPath.row],objectName: itemName[indexPath.row], currentcategoryId: categoryId[indexPath.row], currentObjectId: indexPath.row, objectPrice: itemPrice[indexPath.row], userIndentifier: userIndentifier)
            navigationController?.pushViewController(vc, animated: true)
    }
}

extension ShoppingCartsViewController: DeleteButtonAction {

    func deleteAction(currentTag: Int) {

        shoppingViewModel?.deleteItem(userIdentifier: userIndentifier, itemTag: currentTag, itemNameArray: itemName, itemImageArray: itemImage, itemPriceArray: itemPrice)
        if (itemName.count - 1) > currentTag {
            
            for i in currentTag..<(itemName.count - 1) {
                let nextItem = i + 1
                itemName[i] = itemName[nextItem]
                itemImage[i] = itemImage[nextItem]
                itemPrice[i] = itemPrice[nextItem]
            }
            itemName.remove(at: itemName.count - 1)
            itemImage.remove(at: itemName.count - 1)
            itemPrice.remove(at: itemName.count - 1)
            amountOfItems -= 1
        }
        shopCollectionView.collectionView.reloadData()
    }
}
