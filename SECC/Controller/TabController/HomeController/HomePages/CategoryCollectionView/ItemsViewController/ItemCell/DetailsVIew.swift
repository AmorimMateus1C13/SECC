//
//  DetailsVIew.swift
//  SECC
//
//  Created by Mateus Amorim on 30/11/22.
//

import Foundation
import UIKit
import SnapKit

protocol ButtonsActions {
    func addInCart(itemText: String, valueItem: String, imageItem: UIImage, detailItem: String)
    func buyItem()
}

class DetailsView: UIView {
    
    var delegate: ButtonsActions?
    
    var imageItem = UIImage()
    
    let howImages: Int = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let starCont: Int = 5
    
    var stackView1: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemFill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .top
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    var itemTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 21)
       
        title.textAlignment = .center
        title.numberOfLines = 1
        title.textColor = .black
        title.highlightedTextColor = .black
        title.isHighlighted = true
        return title
    }()
    
   
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30) , height: (UIScreen.main.bounds.width/2))
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ImagesItemsCollectionViewCell.self, forCellWithReuseIdentifier: ImagesItemsCollectionViewCell.identifier)
        
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        
        return collection
        
    }()
    
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = howImages
        page.currentPage = 0
        page.addTarget(self, action: #selector(pageTapped(sender:)), for: .touchUpInside)
       return page
    }()
    
    @objc func pageTapped(sender: UIPageControl) {
        collectionView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    var itemValue: UILabel = {
        let value = UILabel()
        value.font = UIFont.systemFont(ofSize: 25)
        value.textAlignment = .justified
        value.numberOfLines = 1
        value.textColor = .black
        return value
    }()
    
    let detailFx: UILabel = {
        let detail = UILabel()
        detail.text = "Detalhes"
        detail.textAlignment = .justified
        detail.font = UIFont.boldSystemFont(ofSize: 17)
        detail.numberOfLines = 1
        detail.textColor = .black
        return detail
    }()
    
    var detailsItem: UILabel = {
        let detail = UILabel()
        detail.font = UIFont.systemFont(ofSize: 14)
        detail.textAlignment = .justified
        detail.numberOfLines = 0
        detail.textColor = .black
        return detail
    }()
    
    var addInCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar ao Carrinho", for: .normal)
        
        button.layer.borderWidth = 3
        button.layer.borderColor = Colors.borderButtons
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        button.setTitleColor(Colors.addInCartBackButton, for: .normal)
        
        button.addTarget(self, action: #selector(addInCartTapped), for: .touchUpInside)
        return button
    }()
    
    var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alugar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 5
        button.backgroundColor = Colors.addInCartBackButton
        button.setTitleColor(UIColor(ciColor: .white), for: .normal)
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var stackView2: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemFill
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    var starLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    func setView(imageName: UIImage, valueItem: String, detail: String, title: String) {
       
        imageItem = imageName
        itemValue.text = valueItem
        detailsItem.text = detail
        itemTitle.text = title
    }
    
}

extension DetailsView {
    
    @objc func addInCartTapped() {
        guard let itemText = itemTitle.text else { return }
        guard let value = itemValue.text else { return }
        guard let detail = detailsItem.text else { return }
        
        delegate?.addInCart(itemText: itemText,valueItem: value, imageItem: imageItem, detailItem: detail)
    }
    
    @objc func buyButtonTapped() {
        delegate?.buyItem()
    }
}

extension DetailsView:ConfigurationView {
    
    func viewHierarchy() {
        addSubview(stackView1)
        stackView1.addArrangedSubview(itemTitle)
        stackView1.addArrangedSubview(collectionView)
        stackView1.addArrangedSubview(pageControl)
        stackView1.addArrangedSubview(itemValue)
        stackView1.addArrangedSubview(detailFx)
        stackView1.addArrangedSubview(detailsItem)
        
        addSubview(addInCartButton)
        addSubview(buyButton)
    }
    
    func setConstrants() {
        stackView1.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(220)
        }
        
        pageControl.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(12)
        }

        itemValue.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        detailFx.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
        }

        detailsItem.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)

        }
        
        addInCartButton.snp.makeConstraints { make in
            make.top.equalTo(stackView1.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(addInCartButton.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }
}

extension DetailsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return howImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesItemsCollectionViewCell.identifier, for: indexPath) as? ImagesItemsCollectionViewCell
        
        cell?.changeImage(image: imageItem)
        
//        if imageItem == "Martelo" {
//            DispatchQueue.main.async {
//                cell?.changeImage(image: ItemsMock.tools.hammer[indexPath.row])
//            }
//
//        } else if imageItem == "ChaveInglesa" {
//            DispatchQueue.main.async {
//                cell?.changeImage(image: ItemsMock.tools.keyIngl[indexPath.row])
//            }
//
//        }else if imageItem == "Multimetro"{
//            DispatchQueue.main.async {
//                cell?.changeImage(image: ItemsMock.tools.mult[indexPath.row])
//            }
//        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(collectionView.contentOffset.x / UIScreen.main.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
