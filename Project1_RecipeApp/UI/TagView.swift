//
//  TagView.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import UIKit
import CoreData

class TagView: UIView {
    
    // an array to keep references to the button for each category
    private var categoryButtons: [UIButton] = []
    var selectedCategories: [Category] = []
    private var buttonCategoryMap: [UIButton: Category] = [:]
    
    func setCategories(_ categories: [Category]) {
        // Remove all old buttons
        categoryButtons.forEach({ $0.removeFromSuperview() })
        categoryButtons.removeAll()
        
        // Create new buttons
        categories.forEach { (category) in
            let button = UIButton()
            button.setTitle(category.name, for: .normal)
            button.setTitleColor(.gray, for: .normal) // Set the button text color
            button.backgroundColor = .white // Set the button background color
            button.layer.cornerRadius = 10 // Make the button corners rounded
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.masksToBounds = true // Enable corner radius
            
            // Setup target for button tap
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                        
            
            // Add the button to our view and to our array
            self.addSubview(button)
            categoryButtons.append(button)
            buttonCategoryMap[button] = category
        }
        layoutButtons()
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        if let category = buttonCategoryMap[sender] {
            if let index = selectedCategories.firstIndex(of: category) {
                // The category is currently selected. Deselect it.
                selectedCategories.remove(at: index)
                sender.backgroundColor = .none // Use the default button color
            } else {
                // The category is not currently selected. Select it.
                selectedCategories.append(category)
                sender.backgroundColor = .lightGray // Indicate that the category is selected
            }
        }
    }
    
    func addTag(for category: Category) {
        
    }
    
    
    // Function to layout the buttons
    private func layoutButtons() {
        // for simplicity let's layout them in a horizontal stack view
        let stackView = UIStackView(arrangedSubviews: categoryButtons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

