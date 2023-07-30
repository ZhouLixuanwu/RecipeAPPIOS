//
//  DetailVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    var recipe: Recipe?
    
    // UI Components
    let image = UIImage(systemName: "home")
    var imageView = UIImageView()
    let nameLabel = UILabel()
    let categoriesLabel = UILabel()

    let des = UITextView()
    let riLabel = UILabel()
    
    let riTextView = UITextView()
    
    let insTextView = UITextView()
    let insLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setupUI()
        populateData()
    }
    
    func setupUI() {
        configureImage()
        configureNameLabel()
        configureDesText()
        configureRILabel()
        configureRItext()
        configureInsLabel()
        configureInstext()
    }
    
    func configureImage() {
        // Add image to the view
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Set up constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureNameLabel() {
        // Add label to the view
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureDesText() {
        // Add textView to the view
        des.isEditable = false
        des.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(des)

        // Set up constraints
        NSLayoutConstraint.activate([
            des.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            des.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            des.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureRILabel() {
        // Add label to the view
        riLabel.numberOfLines = 0
        riLabel.text = "Recipe Ingredients"
        riLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            riLabel.topAnchor.constraint(equalTo: des.bottomAnchor, constant: 20),
            riLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureRItext() {
        // Assuming that you have a UITextView for RI text
        riTextView.isEditable = false
        riTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(riTextView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            riTextView.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 20),
            riTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureInsLabel() {
        // Assuming that you have a UILabel for instruction label
        insLabel.numberOfLines = 0
        insLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(insLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            insLabel.topAnchor.constraint(equalTo: riTextView.bottomAnchor, constant: 20),
            insLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            insLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureInstext() {
        // Assuming that you have a UITextView for instruction text
        insTextView.isEditable = false
        insTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(insTextView)

        // Set up constraints
        NSLayoutConstraint.activate([
            insTextView.topAnchor.constraint(equalTo: insLabel.bottomAnchor, constant: 20),
            insTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            insTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            insTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
    func populateData() {
        guard let recipe = recipe else { return }
        nameLabel.text = recipe.name
        // Assume that the categories are stored in a String array in your Recipe model
        //categoriesLabel.text = recipe.category.joined(separator: ", ")
    }
}
