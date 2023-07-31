//
//  Ingredient+CoreDataProperties.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var unit: String?
    @NSManaged public var fromWhichRI: RecipeIngredient?

}

extension Ingredient : Identifiable {

}
