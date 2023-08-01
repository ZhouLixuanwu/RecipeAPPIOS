//
//  DetailVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit
import CoreData

class DetailVC: UIViewController {
    
    var recipe: Recipe?
    var categories: [Category]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // UI Components
    let image = UIImage(systemName: "square.and.arrow.up")
    var imageView = UIImageView()
    
    var tagView = TagView()
    var scrollView = UIScrollView()
    
    let nameText = UITextField()
    let desText = UITextField()
    let riLabel = UILabel()
    let serveText = UITextField()
    let serveButton = UIButton()
    let insLabel = UILabel()
    let insText = UITextField()
    
    let favButton = UIButton()
    let editButton = UIButton()
    
    //var ingredientsStackView = IngredientStackView()
    var ingredientsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        populateData()
    }
    
    func setupUI() {
        configureImage()
        configureNameText()
        configureTagView()
        
        configureDesText()
        configureRILabel()
        setupScrollView()
        configureInsLabel()
        configureInstext()
        configureServeText()
        configureServeButton()
        setupFavButton()
        setupEditButton()
    }
    
    func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.backgroundColor = .lightGray
        
        //ingredientsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: riLabel.bottomAnchor, constant: 20),
            scrollView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        ingredientsStackView.axis = .vertical
        ingredientsStackView.spacing = 10
        scrollView.addSubview(ingredientsStackView)
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            ingredientsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            ingredientsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            ingredientsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func configureImage() {
        // Add image to the view
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Set up constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureNameText() {
        // Add label to the view
        view.addSubview(nameText)
        nameText.textAlignment = NSTextAlignment.center
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.backgroundColor = .systemBrown

        // Set up constraints
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureTagView() {
        tagView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagView)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),
            tagView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tagView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            tagView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureDesText() {
        // Add textView to the view
        view.addSubview(desText)
        desText.translatesAutoresizingMaskIntoConstraints = false
        desText.backgroundColor = .systemBrown
        
        // Set up constraints
        NSLayoutConstraint.activate([
            desText.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 20),
            desText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            desText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureRILabel() {
        // Add label to the view
        view.addSubview(riLabel)
        riLabel.text = "Recipe Ingredients"
        riLabel.backgroundColor = .white
        riLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints
        NSLayoutConstraint.activate([
            riLabel.topAnchor.constraint(equalTo: desText.bottomAnchor, constant: 20),
            riLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180)
        ])
    }
    
    func configureServeText() {
        view.addSubview(serveText)
        serveText.text = "1"
        serveText.backgroundColor = .systemBrown
        serveText.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints
        NSLayoutConstraint.activate([
            serveText.topAnchor.constraint(equalTo: desText.bottomAnchor, constant: 20),
            serveText.leadingAnchor.constraint(equalTo: riLabel.trailingAnchor, constant: 20),
            serveText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
    
    func configureServeButton() {
        view.addSubview(serveButton)
        serveButton.setTitle("change", for: .normal)
        serveButton.backgroundColor = .systemBrown
        serveButton.translatesAutoresizingMaskIntoConstraints = false
        serveButton.addTarget(self, action: #selector(updateServe), for: .touchUpInside)
        // Set up constraints
        NSLayoutConstraint.activate([
            serveButton.topAnchor.constraint(equalTo: desText.bottomAnchor, constant: 20),
            serveButton.leadingAnchor.constraint(equalTo: serveText.trailingAnchor, constant: 5),
            serveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            serveButton.bottomAnchor.constraint(equalTo: riLabel.bottomAnchor)
        ])
    }
    
    @objc func updateServe() {
        for view in ingredientsStackView.arrangedSubviews {
            ingredientsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        guard let recipe = recipe else { return }
        //MARK: loop through each ingredient in the recipe
        //MARK: create an IngredientStackView for each one, and add it to ingredientsStackView:
        if let ingredients = recipe.recipeIngredient?.allObjects as? [RecipeIngredient] {
            //ingredientsStackView.clearIngredients()
            for ingredient in ingredients {
                let ingredientView = IngredientStackView()
                let numberofServeString: String? = serveText.text
                let numberofServe = Double(numberofServeString!)!
                ingredientView.setupWith(ingredient: ingredient.ingredient!, serveNumber: numberofServe)
                //ingredientView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
                ingredientsStackView.addArrangedSubview(ingredientView)
                //print("added the ingredient \(ingredient.quantity)")
            }
        }
        //setupScrollView()
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
            insLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            insLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            insLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureInstext() {
        // Assuming that you have a UITextView for instruction text
        insText.translatesAutoresizingMaskIntoConstraints = false
        insText.backgroundColor = .systemBrown
        view.addSubview(insText)

        // Set up constraints
        NSLayoutConstraint.activate([
            insText.topAnchor.constraint(equalTo: insLabel.bottomAnchor, constant: 20),
            insText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            insText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupFavButton() {
        view.addSubview(favButton)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart")
        favButton.setImage(heartImage, for: .normal)
        let filledHeartImage = UIImage(systemName: "heart.fill")
        favButton.setImage(filledHeartImage, for: .selected)
        favButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        // Set button's initial color to gray
        favButton.tintColor = .gray
        
        NSLayoutConstraint.activate([
            favButton.heightAnchor.constraint(equalToConstant: 30),
            favButton.widthAnchor.constraint(equalToConstant: 30),
            favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            favButton.topAnchor.constraint(equalTo: insText.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        //sender.tintColor = sender.isSelected ? .red : .gray
        // Retrieve the array of favorited recipe IDs
        var favoriteRecipeIDs = UserDefaults.standard.array(forKey: "favoriteRecipeIDs") as? [String] ?? []
        if let recipeId = recipe?.name {
            if sender.isSelected {
                favoriteRecipeIDs.append(recipeId)
                sender.tintColor = .red
            } else {
                favoriteRecipeIDs.removeAll(where: { $0 == recipeId })
                sender.tintColor = .gray
            }
        }

        // Save the updated array back to UserDefaults
        UserDefaults.standard.setValue(favoriteRecipeIDs, forKey: "favoriteRecipeIDs")
            
        // Post a notification to let other VCs know that the favorites list has been updated
        NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
    }
    
    
    func setupEditButton() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(editSaved), for: .touchUpInside)
        editButton.setTitle("Save Changes", for: .normal)
        editButton.backgroundColor = .black
        NSLayoutConstraint.activate([
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.topAnchor.constraint(equalTo: insText.bottomAnchor, constant: 10),
            editButton.leadingAnchor.constraint(equalTo: favButton.trailingAnchor, constant: 40),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
    
    @objc func editSaved() {
        guard let recipeName = recipe?.name else { return }
        
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", recipeName)
        
        do {
            let fetchedRecipes = try context.fetch(fetchRequest)
            
            // Since recipe names are unique, there should be only one matching recipe
            guard let recipeToUpdate = fetchedRecipes.first else { return }
            
            // Update the properties of the recipe
            recipeToUpdate.name = nameText.text
            recipeToUpdate.descriptions = desText.text
            recipeToUpdate.instructions = insText.text
            
            //MARK: UPDATE THE INGREDIENT HERE
            
            // Save the changes back to Core Data
            try context.save()
            
            // Re-populate the UI with the updated data
            populateData()
            
            print("Recipe updated successfully")
        } catch {
            print("Failed to update recipe: \(error)")
        }
    }
    
    func populateData() {
        guard let recipe = recipe else { return }
        nameText.text = recipe.name
        nameText.textColor = .black
        desText.text = recipe.descriptions
        desText.textColor = .black
        insText.text = recipe.instructions
        insText.textColor = .black
        
        if let categories = recipe.recipeCategory?.allObjects as? [Category] {
            tagView.setCategories(categories)
        }
        
        //MARK: loop through each ingredient in the recipe
        //MARK: create an IngredientStackView for each one, and add it to ingredientsStackView:
        if let ingredients = recipe.recipeIngredient?.allObjects as? [RecipeIngredient] {
            //ingredientsStackView.clearIngredients()
            for ingredient in ingredients {
                let ingredientView = IngredientStackView()
                let numberofServeString: String? = serveText.text
                let numberofServe = Double(numberofServeString!)!
                ingredientView.setupWith(ingredient: ingredient.ingredient!, serveNumber: numberofServe)
                //ingredientView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
                ingredientsStackView.addArrangedSubview(ingredientView)
                //print("added the ingredient \(ingredient.quantity)")
            }
        }
    }
}
