//
//  AERecipeVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class AERecipeVC: UIViewController {
    
    var onRecipeSave: (() -> Void)?
    // for save the recipe data when go back to home page
    
    let recipeNameField = InputFieldView()
    let recipeDescription = InputFieldView()
    let recipeInstruction = InputFieldView()
    let saveButton = UIButton()
    let testbutton = UIButton()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        configureUI()
    }
    
    func configureUI() {
        setupSaveButton()
        setupName()
        setupDescription()
        setupInstruction()
        setuptestButton()
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
        do {
            try self.context.save()
        }
        catch {
            //
        }
        
        //refresh the table view
        onRecipeSave?()
    }
    
    
    func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .systemBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
        
        //probably this would be better??
        //nav.viewControllers.first?.navigationItem.rightBarButtonItem
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    func setupName() {
        view.addSubview(recipeNameField)
        recipeNameField.label.text = "Recipe Name"
        recipeNameField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            recipeNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            recipeNameField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 30),
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
    
    func setupInstruction() {
        view.addSubview(recipeInstruction)
        recipeInstruction.label.text = "Instruction"
        recipeInstruction.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeInstruction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            recipeInstruction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            recipeInstruction.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: 30),
            recipeInstruction.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    @objc func saveRecipe() {
        //recipeNameField.textField
        
        print("pressed Save")
        let newRecipe = Recipe(context: self.context)
        newRecipe.name = recipeNameField.textField.text
        newRecipe.descriptions = recipeDescription.textField.text
        newRecipe.instructions = recipeInstruction.textField.text
        
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

}
