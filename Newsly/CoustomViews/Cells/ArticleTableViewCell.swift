//
//  ArticleTableViewCell.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 15/02/25.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    var ArictleImage = UIImageView()
    var ArticleTitle = UILabel()
    var ArticleDescription = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ArictleImage.translatesAutoresizingMaskIntoConstraints = false
        ArticleTitle.translatesAutoresizingMaskIntoConstraints = false
        ArticleDescription.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(ArictleImage)
        ArictleImage.image = UIImage(named: "404")
        
        ArticleTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        ArticleTitle.numberOfLines = 2

        addSubview(ArticleTitle)
        
        
        ArticleDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ArticleDescription.lineBreakMode = .byTruncatingTail
        ArticleDescription.minimumScaleFactor = 0.7
        ArticleDescription.numberOfLines = 4
        
        addSubview(ArticleDescription)
        
        NSLayoutConstraint.activate([
            
            ArictleImage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            ArictleImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            ArictleImage.widthAnchor.constraint(equalToConstant: 130),
            ArictleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            
            ArticleTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ArticleTitle.leadingAnchor.constraint(equalTo: ArictleImage.trailingAnchor, constant: 10),
            ArticleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            
            ArticleDescription.topAnchor.constraint(equalTo: ArticleTitle.bottomAnchor, constant: 5),
            ArticleDescription.leadingAnchor.constraint(equalTo: ArictleImage.trailingAnchor, constant: 10),
            ArticleDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ArticleDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            
        ])
            
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
