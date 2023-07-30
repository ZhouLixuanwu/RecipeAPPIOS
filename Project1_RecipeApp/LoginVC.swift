//
//  LoginVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    let LoginButton = UIButton()
    let UserNameLabel = UILabel()
    let PasswordLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureUI()
    }
    
    func configureUI() {
        configureUserName()
        configurePassword()
        configureLoginButton()
    }
    
    func configureUserName() {
        view.addSubview(UserNameLabel)
        UserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        UserNameLabel.text = "Username"
        UserNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        UserNameLabel.textAlignment = .center
        UserNameLabel.numberOfLines = 0
        UserNameLabel.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            UserNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            UserNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 30),
            UserNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30)
        ])
    }
    
    func configurePassword() {
        view.addSubview(PasswordLabel)
        PasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        PasswordLabel.text = "Password"
        PasswordLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        PasswordLabel.textAlignment = .center
        PasswordLabel.numberOfLines = 0
        PasswordLabel.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            PasswordLabel.topAnchor.constraint(equalTo: UserNameLabel.bottomAnchor, constant: 30),
            PasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 30),
            PasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30)
        ])
        
    }
    
    func configureLoginButton() {
        view.addSubview(LoginButton)
        LoginButton.setTitle("Login", for: .normal)
        LoginButton.backgroundColor = .systemGray
        LoginButton.tintColor = .white
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        LoginButton.addTarget(self, action: #selector(presentHome), for: .touchUpInside )
        NSLayoutConstraint.activate([
            LoginButton.topAnchor.constraint(equalTo: PasswordLabel.bottomAnchor, constant: 30),
            LoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 30),
            LoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            LoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentHome() {
        //present(HomeVC(), animated: true)
        let tabBarController = TabBarController()
        SceneDelegate.shared.window?.rootViewController = tabBarController
        SceneDelegate.shared.window?.makeKeyAndVisible()
    }
    
}


