//
//  HomeVC.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/27/23.
//

import Foundation
import UIKit
import CoreData

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var isAscendingOrder = false
    
    let AEButton = UIButton()
    let tableView = UITableView()
    //var collectionView: UICollectionView()
    private var collectionView: UICollectionView?
    //@IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Recipe]?
    var categories: [Category]?
    var selectedCategories = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: Notification.Name("favoritesUpdated"), object: nil)
        configureUI()
        //whatisRecipe()
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        configureLoginButton()
        configureTableView()
        configureCollectionView()
        createSortButton()
        fetchRecipe()
        fetchCategory()
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
            AEButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -120),
            AEButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentAEVC() {
        let aevc = AERecipeVC()
        
        //set the call back from AEVC, and update table view cells
        aevc.onRecipeSave = {
            [weak self] in self?.fetchRecipe()
        }
        
        //set the callback from AEVC, and update categories
        aevc.onCategoryUpdate = {
            [weak self] in self?.fetchCategory()
        }
        
        navigationController?.pushViewController(aevc, animated: true)
    }
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)

        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: AEButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
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
            tableView.topAnchor.constraint(equalTo: AEButton.bottomAnchor, constant: 80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50) // Adjust this as per your needs
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CollectionCell.identifier, for: indexPath) as! CollectionCell

        let category = self.categories?[indexPath.row]
        cell.button.setTitle(category?.name, for: .normal)
        cell.button.addTarget(self, action: #selector(categoryButtonTapped(sender:)), for: .touchUpInside)
        // Configure your button appearance here, e.g. background color, font, etc.
        
        return cell
    }
    
    @objc func categoryButtonTapped(sender: UIButton) {
        if let categoryTitle = sender.title(for: .normal) {
            if selectedCategories.contains(categoryTitle) {
                selectedCategories.removeAll { $0 == categoryTitle }
                //sender.backgroundColor = .white //Change color to indicate de-selection
            } else {
                selectedCategories.append(categoryTitle)
                sender.backgroundColor = .lightGray //Change color to indicate selection
            }
            fetchRecipe() //Fetch recipes after updating the selection
        }
    }

    //MARK: Fetch all updated Categories, after hitting "add" from AERecipeVC
    func fetchCategory() {
        do {
            let request = Category.fetchRequest() as NSFetchRequest<Category>
            //TODO: combine the tags filtering
            
            //let pred = NSPredicate(format: "name CONTAINS '123'")
            //request.predicate = pred
            
            self.categories = try context.fetch(request)//request)
            //print("\(self.categories)")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        catch {
           //
        }
    }
    
    //MARK: Fetch Recipe with query, combined with a compound predicate, filtering the Recipe has all the specified categories.
    func fetchRecipe() {
        do {
            let request = Recipe.fetchRequest() as NSFetchRequest<Recipe>
            
            if !selectedCategories.isEmpty {
                var predicates: [NSPredicate] = []
                for category in selectedCategories {
                    let predicate = NSPredicate(format: "SUBQUERY(recipeCategory, $x, $x.name == %@).@count > 0", category)
                    predicates.append(predicate)
                }
                
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            }
            
            let sort = NSSortDescriptor(key: "name", ascending: isAscendingOrder)
            request.sortDescriptors = [sort]
            
            self.items = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
           //
        }
    }
    
    // MARK: - Sorting with Recipe Name
    func createSortButton() {
        let sortButton = UIButton()
        view.addSubview(sortButton)
        sortButton.setTitle("order", for: .normal)
        sortButton.addTarget(self, action: #selector(pressOrder), for: .touchUpInside)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sortButton.bottomAnchor.constraint(equalTo: AEButton.bottomAnchor),
            sortButton.topAnchor.constraint(equalTo: AEButton.topAnchor),
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -30),
            sortButton.leadingAnchor.constraint(equalTo: AEButton.trailingAnchor, constant: 30)
        ])
    }
    
    @objc func pressOrder() {
        isAscendingOrder.toggle()
        fetchRecipe()
    }
    
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            fatalError("The TableView could not dequeue a CustomTableViewCell in ViewController")
        }
        
        let recipe = self.items?[indexPath.row]
        cell.recipeNameLabel.text = recipe?.name
//        if let categories = recipe?.recipeCategory?.allObjects as? [Category] {
//            cell.cateTagView.setCategories(categories)
//        }
        
        if let categories = recipe?.recipeCategory?.allObjects as? [Category] {
            cell.cateTagView.setCategories(categories)
//            let categoryNames = categories.compactMap { $0.name as? String}
//            let categoriesText = categoryNames.joined(separator: ", ")
//            cell.textLabel?.text = categoriesText
            for view in cell.cateTagView.subviews {
                if let button = view as? UIButton {
                    button.isUserInteractionEnabled = false
                }
            }
        }
        
        //MARK: favrite button updated
        let favoriteRecipeIDs = UserDefaults.standard.array(forKey: "favoriteRecipeIDs") as? [String] ?? []
        cell.favoriteButton.isSelected = favoriteRecipeIDs.contains((recipe?.name ?? "")!)
        cell.favoriteButton.tintColor = cell.favoriteButton.isSelected ? .red : .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell selection
        guard let selectedRecipe = self.items?[indexPath.row] else {return}
        
        
        //let detailVC = TestPageVC()
        let detailVC = DetailVC()
        detailVC.recipe = selectedRecipe
        
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
    
    
    //MARK: Update the button's status when going back from DetailVC
    @objc func favoritesUpdated() {
        // When the favorites list is updated, reload the table view
        tableView.reloadData()
    }
    
    
    //MARK: For testing
    func whatisRecipe() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        do {
            let recipes = try context.fetch(fetchRequest)
            for recipe in recipes {
                print("Recipe Name: \(recipe.name ?? "")")
                if let categories = recipe.recipeCategory?.allObjects as? [Category] {
                    for category in categories {
                        print("Category Name: \(category.name ?? "")")
                    }
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

}
