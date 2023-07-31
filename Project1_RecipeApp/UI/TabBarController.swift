//
//  TabBarController.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: TabBarController
    var userDefaults: UserDefaultsData
    
    init(_ userDefaults: UserDefaultsData) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        print("the userDefaults: \(userDefaults)")
        // Do any additional setup after loading the view.
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .gray
    }
    

    private func setupTabs() {
        let home = self.creatNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeVC())
        let settingsVC = SettingsVC()
        settingsVC.userDefaults = userDefaults
        print("TabBarController userDefaults: \(userDefaults)")
        let settings = self.creatNav(with: "Settings", and: UIImage(systemName: "gear"), vc: settingsVC)
        self.setViewControllers([home, settings], animated: true)
    }
    
    private func creatNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title + " Page"
        //nav.viewControllers.first?.navigationItem.leftBarButtonItem =
        return nav
    }

}
