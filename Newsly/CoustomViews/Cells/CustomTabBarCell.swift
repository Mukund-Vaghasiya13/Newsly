//
//  CustomTabBarCell.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit

class CustomTabBarCell: UICollectionViewCell {
    
    static let identifier = "TabCell"
    
    var label = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -4),
        ])
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
