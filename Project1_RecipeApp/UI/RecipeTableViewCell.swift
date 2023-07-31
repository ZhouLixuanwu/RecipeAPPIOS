//
//  RecipeTableViewCell.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/29/23.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        let nameForImage = "square.and.arrow.up"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //configures
        imageView.image = UIImage(systemName: nameForImage)
        return imageView
    }()
    
    let recipeNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let favoriteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //button.setTitle("fav", for: .normal)
        //button.backgroundColor = .gray
        //configure
        let heartImage = UIImage(systemName: "heart")
        button.setImage(heartImage, for: .normal)
        let filledHeartImage = UIImage(systemName: "heart.fill")
        button.setImage(filledHeartImage, for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        // Set button's initial color to gray
        button.tintColor = .gray
        return  button
    }()
    
    let cateTagView: TagView = {
        let cateTag = TagView()
        cateTag.translatesAutoresizingMaskIntoConstraints = false
        return cateTag
    }()
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        // If the button is selected, change its color to red. If not, change its color back to gray
        sender.tintColor = sender.isSelected ? .red : .gray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(cateTagView)
        
        NSLayoutConstraint.activate([
            cellImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellImageView.heightAnchor.constraint(equalToConstant: 100),
            cellImageView.widthAnchor.constraint(equalToConstant: 100),
            
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            recipeNameLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 20),
            recipeNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cateTagView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            cateTagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cateTagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cateTagView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            favoriteButton.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
