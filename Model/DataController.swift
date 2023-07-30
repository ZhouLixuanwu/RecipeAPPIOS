//
//  DataController.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/28/23.
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "RecipeApp")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("data saved")
        }
        catch {
            print("we failed save the data")
        }
    }
    
    
    func addCategory(name: String, context: NSManagedObjectContext) {
        let category = Category(context: context)
        category.name = name
        save(context: context)
    }
    
    func editCategory(category: Category, name: String, context: NSManagedObjectContext) {
        category.name = name
        
        save(context: context)
    }
    
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    let categoryNames = ["breakfast","lunch","dinner","drink","meat","bread"]
//
//    for name in categoryNames {
//        name
//    }
//
//    do {
//        try context.save()
//    }
//    catch let error as NSError {
//        print("could not save. \(error), \(error.userInfo)")
//    }
}
