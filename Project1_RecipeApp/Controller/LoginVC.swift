//
//  LoginVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    var userDefaults: UserDefaultsData!
    
    let LoginButton = UIButton()
    let UserNameLabel = UILabel()
    let userNameInput = UITextField()
    let PasswordLabel = UILabel()
    let passwordInput = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureUI()
    }
    
    func configureUI() {
        configureUserName()
        configureUsernameInputField()
        configurePassword()
        configurePasswordInputField()
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
            UserNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UserNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
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
            PasswordLabel.topAnchor.constraint(equalTo: userNameInput.bottomAnchor, constant: 30),
            PasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PasswordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
    }
    
    func configureUsernameInputField() {
        view.addSubview(userNameInput)
        userNameInput.translatesAutoresizingMaskIntoConstraints = false
        
        userNameInput.placeholder = "Enter user name here"
        userNameInput.textAlignment = .center
        userNameInput.font = .systemFont(ofSize: 20, weight: .medium)
        userNameInput.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            userNameInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            userNameInput.heightAnchor.constraint(equalToConstant: 30),
            userNameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameInput.topAnchor.constraint(equalTo: UserNameLabel.bottomAnchor, constant: 10),
        ])
    }
    
    func configurePasswordInputField() {
        view.addSubview(passwordInput)
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.placeholder = "Enter password here"
        passwordInput.textAlignment = .center
        passwordInput.font = .systemFont(ofSize: 20, weight: .medium)
        passwordInput.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            passwordInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordInput.heightAnchor.constraint(equalToConstant: 30),
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: PasswordLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
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
            LoginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30),
            LoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 30),
            LoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            LoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentHome() {
        print("Clicked login button.")
        // Change this to check for username and password when implemented 2 UITextViews
        if (userNameInput.text == "123" && passwordInput.text == "123") {
            userDefaults.login()
            //present(HomeVC(), animated: true)
            let tabBarController = TabBarController(userDefaults)
            SceneDelegate.shared.window?.rootViewController = tabBarController
            SceneDelegate.shared.window?.makeKeyAndVisible()
        } else {
            print("username and password should be 123")
        }
    }
}


