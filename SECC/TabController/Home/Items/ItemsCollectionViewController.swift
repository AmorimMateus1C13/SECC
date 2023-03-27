//
//  ItemsCollectionViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import UIKit
import SnapKit

class ItemsCollectionViewController: UIViewController {
    
    var itemsViewModel: ItemsViewModel?
    var amountOfObjects: Int = Int()
    var categoryTitle: String = String()
    var categoryId: Int = Int()
    var objectImage: [String] = []
    var objectNames: [String] = []
    var objectPrice: [String] = []
    var userIndentifier: String = String()
    
    init(categoryTitle: String, categoryId: Int, itemsViewModel: ItemsViewModel? = ItemsViewModel(), userIndentifier: String ) {
        self.categoryTitle = categoryTitle
        self.categoryId = categoryId
        self.itemsViewModel = itemsViewModel
        self.userIndentifier = userIndentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = categoryTitle
        view.backgroundColor = Colors.LoginView.backgroundView
        navigationController?.navigationBar.topItem?.backButtonTitle = TitlesOfControllers.tabTitles.homeTitle
        addInView()
        makeConstrants()
        itemsViewModel?.getAmountOfObjects(category: categoryId)
        itemsViewModel?.delegate = self
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2) - 16, height: (view.frame.size.width/2) - 4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
}

extension ItemsCollectionViewController {
    
    func addInView() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    func makeConstrants() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
}

extension ItemsCollectionViewController: ItemsViewModelProtocol {
    func getAmountObjects(amountOfObjects: Int) {
        self.amountOfObjects = amountOfObjects
        collectionView.reloadData()
    }
    
    func getObjectImages(objectImages: String) {
        self.objectImage.append(objectImages)
        collectionView.reloadData()
    }
    
    func getObjectName(objectName: String) {
        self.objectNames.append(objectName)
        collectionView.reloadData()
    }
    
    func getObjectPrice(objectPrice: String) {
        self.objectPrice.append(objectPrice)
        collectionView.reloadData()
    }
    
}

extension ItemsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amountOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as? ItemsCollectionViewCell
        
        if objectImage != [] && objectNames != [] && objectPrice != [] {
            cell?.updateItems(image: objectImage[indexPath.row], title: objectNames[indexPath.row], value: objectPrice[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let vc = DetailsItemViewController(categoryName: categoryTitle,objectName: objectNames[indexPath.row], currentcategoryId: categoryId, currentObjectId: indexPath.row, objectPrice: objectPrice[indexPath.row], userIndentifier: userIndentifier)
            navigationController?.pushViewController(vc, animated: true)
    }
}
