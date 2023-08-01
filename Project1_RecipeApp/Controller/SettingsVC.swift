//
//  SettingsVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit
import CoreData

class SettingsVC: UIViewController {
    
    var userDefaults: UserDefaultsData!
    let LogoutButton = UIButton()
    
    let measureButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureUI()
    }
    
    func configureUI() {
        configureLogoutButton()
        configureMeasureButton()
    }
    
    func configureLogoutButton() {
        view.addSubview(LogoutButton)
        LogoutButton.addTarget(self, action: #selector(pressLogout), for: .touchUpInside)
        LogoutButton.setTitle("Logout", for: .normal)
        LogoutButton.backgroundColor = .gray
        
        LogoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LogoutButton.heightAnchor.constraint(equalToConstant: 50),
            LogoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            LogoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            LogoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func configureMeasureButton() {
        view.addSubview(measureButton)
        measureButton.addTarget(self, action: #selector(pressChange), for: .touchUpInside)
        measureButton.setTitle("Change Measurement", for: .normal)
        measureButton.backgroundColor = .gray
        
        measureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            measureButton.heightAnchor.constraint(equalToConstant: 50),
            measureButton.topAnchor.constraint(equalTo: LogoutButton.safeAreaLayoutGuide.topAnchor, constant: 130),
            measureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            measureButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    @objc func pressChange() {
        print("measure changed")
        
        //MARK: for recipe in Recipes, change all ingredients and units
        
    }
    
    
    @objc func pressLogout() {
        print("Clicked logout button.")
        userDefaults.logout()
        
        let loginVC = LoginVC()
        loginVC.userDefaults = userDefaults
        SceneDelegate.shared.window?.rootViewController = loginVC
        SceneDelegate.shared.window?.makeKeyAndVisible()
    }

}
