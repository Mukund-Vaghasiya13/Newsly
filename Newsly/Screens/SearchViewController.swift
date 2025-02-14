//
//  SearchViewController.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguerViewAndNavigationBar()
        
    }
    
    func ConfiguerViewAndNavigationBar(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search News 🔎"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
