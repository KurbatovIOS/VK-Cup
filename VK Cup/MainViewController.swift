//
//  ViewController.swift
//  VK Cup
//
//  Created by Kurbatov Artem on 17.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let hintLabel = UILabel()
    private let laterButton = UIButton()
    private let continueButton = UIButton()
    
    private let categoriesCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private var categories = ["Спорт", "Компьютерные игры", "Кино", "Музыка", "Мультфильмы", "Путешествия", "Природа", "Еда", "Юмор", "Новости", "Рестораны", "Животные", "Театры", "Сериалы", "Спорт", "Компьютерные игры", "Кино", "Музыка", "Мультфильмы", "Путешествия", "Природа", "Еда", "Юмор", "Новости", "Рестораны"]
    
    private var selectedCells = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        categories.shuffle()
        
        configureHintLabel()
        configureLaterButton()
        configureContinueButton()
        configureCategoriesCollection()
    }
    
    
    private func configureHintLabel() {
        
        view.addSubview(hintLabel)
        
        hintLabel.text = "Отметьте то, что вам интререстно, чтобы настроить Дзен"
        hintLabel.textColor = .systemGray
        hintLabel.numberOfLines = 0
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hintLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            hintLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            hintLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func configureLaterButton() {
        
        view.addSubview(laterButton)
        
        laterButton.configuration = .filled()
        laterButton.configuration?.title = "Позже"
        laterButton.configuration?.cornerStyle = .capsule
        laterButton.configuration?.baseForegroundColor = .white
        laterButton.configuration?.baseBackgroundColor = traitCollection.userInterfaceStyle == .dark ? .systemGray6 : .systemGray
        
        laterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            laterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            laterButton.topAnchor.constraint(equalTo: hintLabel.topAnchor),
            laterButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureContinueButton() {
        
        view.addSubview(continueButton)
        
        continueButton.configuration = .filled()
        continueButton.configuration?.title = "Продолжить"
        continueButton.configuration?.cornerStyle = .capsule
        continueButton.configuration?.baseForegroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        continueButton.configuration?.baseBackgroundColor = traitCollection.userInterfaceStyle == .dark ? .white : .systemGray
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            continueButton.heightAnchor.constraint(equalToConstant: 65),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureCategoriesCollection() {
        
        view.addSubview(categoriesCollection)
        
        categoriesCollection.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
                
        categoriesCollection.showsVerticalScrollIndicator = false
        
        categoriesCollection.backgroundColor = .systemBackground
        
        categoriesCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            categoriesCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            categoriesCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            categoriesCollection.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 11),
            categoriesCollection.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -11)
        ])
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell {
            cell.configure(title: categories[indexPath.row])
            cell.onAppereAnimation()
            return cell
        }
        else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = categoriesCollection.cellForItem(at: indexPath) as? CategoryCell {
            
            if selectedCells.contains(indexPath) {
                cell.isSelected = false
                selectedCells.remove(at: selectedCells.firstIndex(of: indexPath)!)
            }
            else {
                selectedCells.append(indexPath)
            }
            cell.setColorAndSign()
        }
    }
}
