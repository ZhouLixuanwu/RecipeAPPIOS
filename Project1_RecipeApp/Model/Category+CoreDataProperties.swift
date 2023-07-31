//
//  Category+CoreDataProperties.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var whichRecipeHas: Recipe?

}

extension Category : Identifiable {

}
