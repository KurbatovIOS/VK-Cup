//
//  CategoryCell.swift
//  VK Cup
//
//  Created by Kurbatov Artem on 17.12.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private let categoryLabel = UILabel()
    private let signImage = UIImageView()
    
    func configure(title: String) {
        
        self.backgroundColor =  .gray
        self.layer.cornerRadius = 15
        
        addSubview(categoryLabel)
        addSubview(signImage)
        
        categoryLabel.text = title
        categoryLabel.textColor = .white
        
        signImage.tintColor = .white
        signImage.image = UIImage(systemName: "plus")
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        signImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 40),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            signImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            signImage.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 5),
            signImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setColorAndSign() {
        
        let viewsOriginalTransform = self.transform
        self.signImage.image = UIImage(systemName: self.isSelected ? "checkmark" : "plus")
        
        UIView.animate(withDuration: 0.6, delay: 0) {
            self.backgroundColor = self.isSelected ? .orange : .gray
            self.transform = CGAffineTransformScale(viewsOriginalTransform, 1.3, 1.3)
        } completion: { _ in
            UIView.animate(withDuration: 0.6, delay: 0) {
                self.transform = CGAffineTransformScale(viewsOriginalTransform, 1, 1)
            }
        }
    }
}
