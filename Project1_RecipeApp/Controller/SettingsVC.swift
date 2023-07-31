//
//  SettingsVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    var userDefaults: UserDefaultsData!
    let LogoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureUI()
    }
    
    func configureUI() {
        configureLogoutButton()
    }
    
    func configureLogoutButton() {
        view.addSubview(LogoutButton)
        LogoutButton.addTarget(self, action: #selector(pressLogout), for: .touchUpInside)
        LogoutButton.setTitle("Logout", for: .normal)
        
        LogoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LogoutButton.heightAnchor.constraint(equalToConstant: 50),
            LogoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            LogoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            LogoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
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
