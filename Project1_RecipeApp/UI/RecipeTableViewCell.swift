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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //configures
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        return imageView
    }()
    
    
    let favoriteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //configure
        return  button
    }()
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //
        return label
    }()
    
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
        contentView.addSubview(categoriesLabel)
        //TODO: constrains needed to be added
        
        NSLayoutConstraint.activate([
            cellImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.heightAnchor.constraint(equalToConstant: 100),
            cellImageView.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 100),
            favoriteButton.widthAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
