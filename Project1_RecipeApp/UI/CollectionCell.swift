//
//  CollectionCell.swift
//  Project1_RecipeApp
//
//  Created by LoveIrelia on 7/30/23.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell {
    
    //MARK: UI To Deal with the Categories Selection
    
    static let identifier = "CustomCollectionViewCell"
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure button
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(TapCategory(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 80),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func TapCategory(_ sender: UIButton) {
        print("\(sender.titleLabel?.text ?? "")")
        sender.isSelected.toggle()
        sender.backgroundColor = button.isSelected ? .systemGreen : .systemBlue
    }
}
