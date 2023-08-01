//
//  AppDelegate.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    //MARK: Add recipe and categories data

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        deleteAllRecipes()
        deleteAllCategories()
        addCategories()
        addRecipe()
        return true
    }
    
    
    func addCategories() {
        let context = persistentContainer.viewContext
        let categoriesToAdd = ["breakfast","lunch","dinner","drink","special"]

        for cate in categoriesToAdd {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", cate)
            
            do {
                let existingCategories = try context.fetch(fetchRequest)
                
                if existingCategories.isEmpty {
                    let newCategory = Category(context: context)
                    newCategory.name = cate
                }
            }
            
            catch {
                print("Failed to fetch category \(cate): \(error)")
            }
        }
        
        do {
            try context.save()
            print("Categories created and saved")
        }
        catch {
            print("Failed to save categories: \(error)")
        }
    }
    
    func deleteAllCategories() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Category.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all categories: \(error)")
        }
    }

    
    func addRecipe() {
        let context = persistentContainer.viewContext

        // Creating Recipe 1
        let recipe1 = Recipe(context: context)
        recipe1.name = "Recipe1"
        recipe1.instructions = "Instructions for Recipe 1"
        recipe1.descriptions = "descriptions for Recipe 1"
        // Assigning categories to Recipe 1
        let breakfastCategory = fetchCategory(named: "breakfast")
        let lunchCategory = fetchCategory(named: "lunch")
        
        //MARK: I set it to breakfast and it got missing?? Why???

        if let breakfastCategory = breakfastCategory {
            recipe1.addToRecipeCategory(breakfastCategory)
            print("1 add brebreakak")
        }
        if let lunchCategory = lunchCategory {
            recipe1.addToRecipeCategory(lunchCategory)
            print("1 add lunch")
        }

        // Creating Recipe 2
        let recipe2 = Recipe(context: context)
        recipe2.name = "Recipe2"
        recipe2.instructions = "Instructions for Recipe 2"
        recipe2.descriptions = "descriptions for Recipe 2"
        
        // Assigning categories to Recipe 2
        let dinnerCategory = fetchCategory(named: "dinner")
        let specialCategory = fetchCategory(named: "special")

        if let dinnerCategory = dinnerCategory {
            recipe2.addToRecipeCategory(dinnerCategory)
        }
        if let specialCategory = specialCategory {
            recipe2.addToRecipeCategory(specialCategory)
        }

        do {
            try context.save()
            print("Recipes created and saved")
        }
        catch {
            print("Failed to save recipes: \(error)")
        }
    }

    func deleteAllRecipes() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all recipes: \(error)")
        }
    }

    // Helper method to fetch a category by name
    func fetchCategory(named: String) -> Category? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", named)
        
        do {
            let existingCategories = try context.fetch(fetchRequest)
            
            return existingCategories.first
        } catch {
            print("Failed to fetch category \(named): \(error)")
            return nil
        }
    }
    
    
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RecipeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

