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
    
    var tagView = TagView()
    let recipeNameField = InputFieldView()
    let recipeDescription = InputFieldView()
    let recipeInstruction = InputFieldView()
    //let saveButton = UIButton()
    let testbutton = UIButton()
    let addButton = UIButton()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
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
    }
    
    func setuptestButton() {
        view.addSubview(testbutton)
        testbutton.setTitle("test", for: .normal)
        testbutton.addTarget(self, action: #selector(testbuttonout), for: .touchUpInside)
        testbutton.setTitle("Save", for: .normal)
        
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
        let newRecipe = Recipe(context: self.context)
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
        addButton.setTitle("Add", for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addoneCategory), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addButton.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func addoneCategory() {
        let cateToAdd = "xxxx"

        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", cateToAdd)
            
        do {
            let existingCategories = try context.fetch(fetchRequest)
            
            if existingCategories.isEmpty {
                let newCategory = Category(context: context)
                newCategory.name = cateToAdd
            }
        }
        catch {
            print("Failed to fetch category \(cateToAdd): \(error)")
        }
        
        do {
            try context.save()
            self.onCategoryUpdate?()
            
            fetchAllCategories()
            tagView.setCategories(allCategories)
            print("Categories created and saved")
        }
        catch {
            print("Failed to save categories: \(error)")
        }
    }
    
    @objc func saveRecipe() {
        //recipeNameField.textField
        
        //print("pressed Save")
        let newRecipe = Recipe(context: self.context)
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
