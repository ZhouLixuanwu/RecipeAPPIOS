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
    let image = UIImage(systemName: "sun.max.circle.fill")
    var imageView = UIImageView()
    
    let nameLabel = UILabel()
    let categoriesLabel = UILabel()
    let des = UILabel()
    
    let riLabel = UILabel()
    let riTextView = UILabel()
    
    let insTextView = UILabel()
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
        view.addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        

        // Set up constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureDesText() {
        // Add textView to the view
        view.addSubview(des)
        des.translatesAutoresizingMaskIntoConstraints = false
        des.backgroundColor = .systemBrown
        
        // Set up constraints
        NSLayoutConstraint.activate([
            des.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            des.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            des.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureRILabel() {
        // Add label to the view
        view.addSubview(riLabel)
        riLabel.numberOfLines = 0
        riLabel.text = "Recipe Ingredients"
        print("made this R I label")
        riLabel.backgroundColor = .white
        riLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints
        NSLayoutConstraint.activate([
            riLabel.topAnchor.constraint(equalTo: des.bottomAnchor, constant: 20),
            riLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureRItext() {
        // Assuming that you have a UITextView for RI text
        riTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(riTextView)
        riTextView.backgroundColor = .systemBrown
        riTextView.text = "Ri1\nRi2\nRi3"
        riTextView.numberOfLines = 0

        // Set up constraints
        NSLayoutConstraint.activate([
            riTextView.topAnchor.constraint(equalTo: riLabel.bottomAnchor, constant: 20),
            riTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureInsLabel() {
//        // Assuming that you have a UILabel for instruction label
        insLabel.numberOfLines = 0
        insLabel.translatesAutoresizingMaskIntoConstraints = false
        insLabel.text = "Instructions"
        insLabel.backgroundColor = .white
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
        insTextView.translatesAutoresizingMaskIntoConstraints = false
        insTextView.backgroundColor = .systemBrown
        view.addSubview(insTextView)

        // Set up constraints
        NSLayoutConstraint.activate([
            insTextView.topAnchor.constraint(equalTo: insLabel.bottomAnchor, constant: 20),
            insTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            insTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    
    func populateData() {
        guard let recipe = recipe else { return }
        nameLabel.text = recipe.name
        des.text = recipe.descriptions
        insTextView.text = recipe.instructions
        
        // Assume that the categories are stored in a String array in your Recipe model
        //categoriesLabel.text = recipe.category.joined(separator: ", ")
    }
}
