//
//  RecipeIngredient+CoreDataProperties.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//
//

import Foundation
import CoreData


extension RecipeIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeIngredient> {
        return NSFetchRequest<RecipeIngredient>(entityName: "RecipeIngredient")
    }

    @NSManaged public var quantity: Double
    @NSManaged public var whichRecipe: Recipe?
    @NSManaged public var ingredient: Ingredient?

}

extension RecipeIngredient : Identifiable {

}
