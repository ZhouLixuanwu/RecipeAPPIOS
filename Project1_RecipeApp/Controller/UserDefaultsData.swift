//
//  UserDefaultsData.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//

import Foundation

public class UserDefaultsData {
    let defaults = UserDefaults.standard
    let IS_LOGGED_IN = "isLoggedIn"
    
    func login() {
        defaults.set(true, forKey: IS_LOGGED_IN)
        print("IS_LOGGED_IN set to true")
    }
    
    func logout() {
        defaults.set(false, forKey: IS_LOGGED_IN)
        print("IS_LOGGED_IN set to true")
    }
    
    func isLoggedIn() -> Bool {
        let loggedInBool = defaults.bool(forKey: IS_LOGGED_IN)
        return loggedInBool
    }
    
    func saveData() {
        print(defaults.dictionaryRepresentation())
        print(defaults.dictionaryRepresentation().keys)
    }
    
    func getData() {
        let isLoggedInBool = defaults.bool(forKey: IS_LOGGED_IN)
        print("isLoggedInBool \(isLoggedInBool)")
    }
    
    func deleteData(){
        defaults.removeObject(forKey: IS_LOGGED_IN)
    }
    
}
