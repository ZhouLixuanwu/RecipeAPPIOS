//
//  HomeVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let AEButton = UIButton()
    let tableView = UITableView()
    //@IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Recipe]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureUI()
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        configureLoginButton()
        configureTableView()
        fetchRecipe()
    }
    
    func configureLoginButton() {
        view.addSubview(AEButton)
        AEButton.addTarget(self, action: #selector(presentAEVC), for: .touchUpInside)
        
        AEButton.setTitle("Add/Edit Recipe", for: .normal)
        AEButton.backgroundColor = .systemGray
        AEButton.tintColor = .white
        AEButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            AEButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            AEButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 30),
            AEButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            AEButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentAEVC() {
        let aevc = AERecipeVC()
        
        //set the call back from AEVC, and update table view cells
        aevc.onRecipeSave = {
            [weak self] in self?.fetchRecipe()
        }
        navigationController?.pushViewController(aevc, animated: true)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        

        //tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: AEButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchRecipe() {
        //var request =
        do {
            self.items = try context.fetch(Recipe.fetchRequest())//request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            fatalError("The TableView could not dequeue a CustomTableViewCell in ViewController")
        }

        let recipe = self.items?[indexPath.row]
        cell.textLabel?.text = recipe?.name
        return cell
    }
    

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell selection
        guard let selectedRecipe = self.items?[indexPath.row] else {return}
        
        
        let detailVC = TestPageVC()
        //let detailVC = DetailVC()
        //detailVC.recipe = selectedRecipe
        
        navigationController?.pushViewController(detailVC, animated: true)
        // This can be used to navigate to a new screen with details about the selected recipe
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            let recipeToRemove = self?.items![indexPath.row]
            self?.context.delete(recipeToRemove!)
            do {
                try self?.context.save()
            }
            
            catch {
                //
            }
            self?.fetchRecipe()
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }

}
