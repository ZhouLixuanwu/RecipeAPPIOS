//
//  AERecipeVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit
import CoreData

class AERecipeVC: UIViewController {
    
    // for saving the recipe data and category status when going back to home page
    var onRecipeSave: (() -> Void)?
    var onCategoryUpdate: (() -> Void)?
    var allCategories: [Category] = []
    var currentRecipe: Recipe?
    var storedIngredients: [Ingredient] = []
    
    var tagView = TagView()
    var scrollView = UIScrollView()
    var ingredientsStackView = UIStackView()
    
    var newRecipeBeingAdded = Recipe()
    
    let recipeNameField = InputFieldView()
    let recipeDescription = InputFieldView()
    let recipeInstruction = InputFieldView()
    //let saveButton = UIButton()
    let testbutton = UIButton()
    let addButton = UIButton()
    let addIngButton = UIButton()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createNewRecipe()
        
        fetchAllCategories()
        configureUI()
    }
    
    func configureUI() {
        //setupSaveButton()
        setupName()
        setupDescription()
        setupTagView()
        setupInstruction()
        setuptestButton()
        setupAddButton()
        setupAddIngButton()
        setupScrollView()
    }
    
    func createNewRecipe() {
        currentRecipe = Recipe(context: self.context)
    }
    
    func setuptestButton() {
        view.addSubview(testbutton)
        //testbutton.setTitle("test", for: .normal)
        testbutton.addTarget(self, action: #selector(testbuttonout), for: .touchUpInside)
        testbutton.setTitle("Save", for: .normal)
        testbutton.setTitleColor(UIColor.black, for: .normal)
        
        testbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testbutton.topAnchor.constraint(equalTo: recipeInstruction.textField.bottomAnchor, constant: 30),
            testbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            testbutton.heightAnchor.constraint(equalToConstant: 30),
            testbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60)
        ])
    }
    
    @objc func testbuttonout() {
        print("pressed Save")
        guard let newRecipe = currentRecipe else { return }
        newRecipe.name = recipeNameField.textField.text
        newRecipe.descriptions = recipeDescription.textField.text
        newRecipe.instructions = recipeInstruction.textField.text
        
        //save to coreData
        let selectedCategories = tagView.selectedCategories
        for category in selectedCategories {
            newRecipe.addToRecipeCategory(category)
        }
        
        do {
            try self.context.save()
        }
        catch {
            //
        }
        //refresh the table view
        onRecipeSave?()
    }
    
    func setupName() {
        view.addSubview(recipeNameField)
        recipeNameField.label.text = "Recipe Name"
        recipeNameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            recipeNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            recipeNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            recipeNameField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupDescription() {
        view.addSubview(recipeDescription)
        recipeDescription.label.text = "Description"
        recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            recipeDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            recipeDescription.topAnchor.constraint(equalTo: recipeNameField.bottomAnchor, constant: 30),
            recipeDescription.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupTagView() {
        tagView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagView)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: 20),
            tagView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tagView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            tagView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        tagView.setCategories(allCategories)
        
    }
    
    func setupInstruction() {
        view.addSubview(recipeInstruction)
        recipeInstruction.label.text = "Instruction"
        recipeInstruction.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeInstruction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            recipeInstruction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            recipeInstruction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            recipeInstruction.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupAddButton() {
        view.addSubview(addButton)
        addButton.setTitle("Add Category", for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addoneCategory), for: .touchUpInside)
        addButton.setTitleColor(UIColor.black, for: .normal)
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addButton.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 140),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.backgroundColor = .lightGray
        
        //ingredientsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
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
    
    func setupAddIngButton() {
        view.addSubview(addIngButton)
        addIngButton.setTitle("Add Ingredient", for: .normal)
        addIngButton.translatesAutoresizingMaskIntoConstraints = false
        addIngButton.addTarget(self, action: #selector(addoneIng), for: .touchUpInside)
        addIngButton.setTitleColor(UIColor.black, for: .normal)
        NSLayoutConstraint.activate([
            addIngButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            addIngButton.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 30),
            addIngButton.widthAnchor.constraint(equalToConstant: 140),
            addIngButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func addoneIng() {
        // Create alert
        let alert = UIAlertController(title: "Add Ingredient", message: "Please enter the category info", preferredStyle: .alert)
        // Add text fields to alert
        alert.addTextField { (textField) in
            textField.placeholder = "Ingredient name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Ingredient quantity"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Ingredient unit"
        }
        // Add "Cancel" button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // Add "Confirm" button
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] (_) in
            guard let ingredientName = alert.textFields![0].text,
                  let ingredientQuantity = Double(alert.textFields![1].text ?? ""),
                  let ingredientUnit = alert.textFields![2].text,
                  let strongSelf = self,
                  let selectedRecipe = strongSelf.currentRecipe else { return }

            
            let newIngredient = Ingredient(context: strongSelf.context)
            newIngredient.name = ingredientName
            newIngredient.unit = ingredientUnit
            let newRecipeIngredient = RecipeIngredient(context: strongSelf.context)
            newRecipeIngredient.quantity = ingredientQuantity
            newRecipeIngredient.ingredient = newIngredient
            newRecipeIngredient.whichRecipe = selectedRecipe

            // Add the new recipe ingredient to the recipe
            selectedRecipe.addToRecipeIngredient(newRecipeIngredient)

            // Append the new ingredient to the storedIngredients array
            strongSelf.storedIngredients.append(newIngredient)
            
//            for ingredient in self!.storedIngredients {
//                let ingredientView = IngredientStackView()
//                ingredientView.setupWith(ingredient: ingredient)
//                //ingredientView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//                self!.ingredientsStackView.addArrangedSubview(ingredientView)
//                //print("added the ingredient \(ingredient.quantity)")
//            }
//            
//            let ingredientView = IngredientStackView()
//            ingredientView.setupWith(ingredient: newIngredient, serveNumber: 1)
//            self?.ingredientsStackView.addArrangedSubview(ingredientView)
//            self?.addIngredientView(ingredient: newIngredient)
            
            do {
                try strongSelf.context.save()
                print("Ingredient and RecipeIngredient created and saved")
                strongSelf.addIngredientView(ingredient: newIngredient)
            }
            catch let error as NSError {
                // Create alert to inform the user
                let errorAlert = UIAlertController(title: "Save Failed", message: "Failed to save ingredient and recipe ingredient: \(error), \(error.userInfo)", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                strongSelf.present(errorAlert, animated: true, completion: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }

    
    func addIngredientView(ingredient: Ingredient) {
        DispatchQueue.main.async {
            let ingredientView = IngredientStackView()
            ingredientView.setupWith(ingredient: ingredient, serveNumber: 1)
            self.ingredientsStackView.addArrangedSubview(ingredientView)
            
            ingredientView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                ingredientView.leadingAnchor.constraint(equalTo: self.ingredientsStackView.leadingAnchor),
                ingredientView.trailingAnchor.constraint(equalTo: self.ingredientsStackView.trailingAnchor),
            ])
        }
    }
    
    @objc func addoneCategory() {
        // Create alert
        let alert = UIAlertController(title: "Add Category", message: "Please enter the category name", preferredStyle: .alert)

        // Add text field to alert
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
        }

        // Add a "Cancel" button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add a "Confirm" button
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] (_) in
            // Get the category name from the text field
            let textField = alert.textFields![0]
            if let cateToAdd = textField.text {
                // Check if self is not nil
                guard let strongSelf = self else { return }
                
                // Use strongSelf instead of self
                let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "name == %@", cateToAdd)
                
                do {
                    let existingCategories = try strongSelf.context.fetch(fetchRequest)

                    if existingCategories.isEmpty {
                        let newCategory = Category(context: strongSelf.context)
                        newCategory.name = cateToAdd
                    }
                }
                catch {
                    print("Failed to fetch category \(cateToAdd): \(error)")
                }

                do {
                    try strongSelf.context.save()
                    strongSelf.onCategoryUpdate?()

                    strongSelf.fetchAllCategories()
                    strongSelf.tagView.setCategories(strongSelf.allCategories)
                    print("Categories created and saved")
                }
                catch {
                    print("Failed to save categories: \(error)")
                }
            }
        }))

        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveRecipe() {
        //recipeNameField.textField
        currentRecipe = Recipe(context: self.context)
        //print("pressed Save")
        guard let newRecipe = currentRecipe else { return }
        newRecipe.name = recipeNameField.textField.text
        newRecipe.descriptions = recipeDescription.textField.text
        newRecipe.instructions = recipeInstruction.textField.text
        // associate selected categories with the new recipe
        let selectedCategories = tagView.selectedCategories
        for category in selectedCategories {
            newRecipe.addToRecipeCategory(category)
        }
        //save to coreData
        do {
            try self.context.save()
        }
        catch {
            //
        }
        //refresh the table view
        onRecipeSave?()
    }
    
    func fetchAllCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        print("tired")
        do {
            allCategories = try context.fetch(fetchRequest)
            //setupTagView()
        }
        catch {
            //
        }
    }

}
