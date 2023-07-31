//
//  Recipe+CoreDataProperties.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?
    @NSManaged public var recipeCategory: NSSet?
    @NSManaged public var recipeIngredient: NSSet?

}

// MARK: Generated accessors for recipeCategory
extension Recipe {

    @objc(addRecipeCategoryObject:)
    @NSManaged public func addToRecipeCategory(_ value: Category)

    @objc(removeRecipeCategoryObject:)
    @NSManaged public func removeFromRecipeCategory(_ value: Category)

    @objc(addRecipeCategory:)
    @NSManaged public func addToRecipeCategory(_ values: NSSet)

    @objc(removeRecipeCategory:)
    @NSManaged public func removeFromRecipeCategory(_ values: NSSet)

}

// MARK: Generated accessors for recipeIngredient
extension Recipe {

    @objc(addRecipeIngredientObject:)
    @NSManaged public func addToRecipeIngredient(_ value: RecipeIngredient)

    @objc(removeRecipeIngredientObject:)
    @NSManaged public func removeFromRecipeIngredient(_ value: RecipeIngredient)

    @objc(addRecipeIngredient:)
    @NSManaged public func addToRecipeIngredient(_ values: NSSet)

    @objc(removeRecipeIngredient:)
    @NSManaged public func removeFromRecipeIngredient(_ values: NSSet)

}

extension Recipe : Identifiable {

}
