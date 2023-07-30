//
//  TabBarController.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        // Do any additional setup after loading the view.
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .gray
    }
    

    private func setupTabs() {
        let home = self.creatNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeVC())
        let settings = self.creatNav(with: "Settings", and: UIImage(systemName: "gear"), vc: SettingsVC())
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
