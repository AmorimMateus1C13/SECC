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
    func addInCart()
    func buyItem()
}

class DetailsView: UIView {
    
    var delegate: ButtonsActions?
    
    var imageItem = UIImage()
    var itemsCollectionImages: [ObjectArrayImages] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.LoginView.backgroundView
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let starCont: Int = 5
    
    var viewWithScroll: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemFill
        view.isScrollEnabled = true
        return view
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
        page.currentPage = 0
        page.addTarget(self, action: #selector(pageTapped(sender:)), for: .touchUpInside)
       return page
    }()
    
    var viewInfoItems: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
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
    
    func setView(itemsCollectionImages: [ObjectArrayImages], valueItem: String, detail: String, title: String) {
        self.itemsCollectionImages = itemsCollectionImages
        itemValue.text = valueItem
        detailsItem.text = detail
        itemTitle.text = title
    }
}

extension DetailsView {
    
    @objc func addInCartTapped() {
//        guard let itemText = itemTitle.text else { return }
//        guard let value = itemValue.text else { return }
//        guard let detail = detailsItem.text else { return }
        
        delegate?.addInCart()
    }
    
    @objc func buyButtonTapped() {
        delegate?.buyItem()
    }
    
    @objc func pageTapped(sender: UIPageControl) {
        collectionView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
}

extension DetailsView:ConfigurationView {
    
    func viewHierarchy() {
        addSubview(viewWithScroll)
        viewWithScroll.addSubview(itemTitle)
        viewWithScroll.addSubview(collectionView)
        viewWithScroll.addSubview(pageControl)
        viewWithScroll.addSubview(itemValue)
        viewWithScroll.addSubview(detailFx)
        viewWithScroll.addSubview(detailsItem)
        addSubview(addInCartButton)
        addSubview(buyButton)
    }
    
    func setConstrants() {
        
        viewWithScroll.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(addInCartButton.snp.top).offset(-8)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(itemTitle.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(220)
        }

        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            make.height.equalTo(12)
            make.trailing.leading.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }

        itemValue.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }

        detailFx.snp.makeConstraints { make in
            make.top.equalTo(itemValue.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }

        detailsItem.snp.makeConstraints { make in
            make.top.equalTo(detailFx.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        
        addInCartButton.snp.makeConstraints { make in
            make.bottom.equalTo(buyButton.snp.top).offset(-8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        
        buyButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }
}

extension DetailsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = itemsCollectionImages.count
        return itemsCollectionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesItemsCollectionViewCell.identifier, for: indexPath) as? ImagesItemsCollectionViewCell
        cell?.changeImage(image: itemsCollectionImages[indexPath.row].itemImage)
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(collectionView.contentOffset.x / UIScreen.main.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
