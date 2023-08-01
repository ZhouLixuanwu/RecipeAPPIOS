//
//  IngStackView.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/31/23.
//

import Foundation
import UIKit
import CoreData

import UIKit
import CoreData

class IngredientStackView: UIStackView {
    private var imageView: UIImageView
    private var nameLabel: UILabel
    private var quantityLabel: UILabel
    private var unitLabel: UILabel
    
    init() {
        imageView = UIImageView()
        nameLabel = UILabel()
        quantityLabel = UILabel()
        unitLabel = UILabel()

        super.init(frame: .zero)
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 10

        setupImageView()
        setupLabels()
        
        self.addArrangedSubview(imageView)
        self.addArrangedSubview(nameLabel)
        self.addArrangedSubview(quantityLabel)
        self.addArrangedSubview(unitLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(ingredient: Ingredient) {
        imageView.image = ingredient.imageName != nil ? UIImage(named: ingredient.imageName!) : UIImage(systemName: "home")
        nameLabel.text = ingredient.name ?? "Unknown"
        quantityLabel.text = ingredient.fromWhichRI?.quantity != nil ? String(ingredient.fromWhichRI!.quantity) : "0"
        unitLabel.text = ingredient.unit ?? "Unknown"
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupLabels() {
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        quantityLabel.font = UIFont.systemFont(ofSize: 16)
        quantityLabel.textColor = .black
        quantityLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        unitLabel.font = UIFont.systemFont(ofSize: 16)
        unitLabel.textColor = .black
        unitLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
