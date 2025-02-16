//
//  SearchViewController.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit

class SearchViewController: UIViewController {

    
    var textField = NLyTextField(placeHolder: "Search 🔎")
    var searchBtn = NLyButton(title: "Search",bgColor: .systemGreen,fontSize: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguerViewAndNavigationBar()
        ConfigureSubViews()
        
    }
    
    func ConfiguerViewAndNavigationBar(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search News 🔎"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func ConfigureSubViews(){
        view.addSubview(textField)
        view.addSubview(searchBtn)
        
        NSLayoutConstraint.activate([
            // TextField Constraints
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            // Search Button Constraints
            searchBtn.topAnchor.constraint(equalTo: textField.topAnchor),
            searchBtn.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            searchBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // Equal Heights
            textField.heightAnchor.constraint(equalToConstant: 50),
            searchBtn.heightAnchor.constraint(equalTo: textField.heightAnchor),
            
            // Equal Width Distribution
            textField.widthAnchor.constraint(equalTo: searchBtn.widthAnchor,multiplier: 2)
        ])

    }
    
}
