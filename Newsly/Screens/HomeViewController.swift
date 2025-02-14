//
//  HomeViewController.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var tabBar:UICollectionView!
    var items = ["Science","Technology","Health","Sports","Entertainment","Politics","Gernal"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguerViewAndNavigationBar()
        ConfigureSubViews()
    }
    
    func ConfiguerViewAndNavigationBar(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "🗞️ Newsly"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    
    }
    
    func ConfigureSubViews(){
        tabBar = UICollectionView(frame: .zero, collectionViewLayout: CustomCollectionViewFlowLayout())
        tabBar.dataSource = self
        tabBar.delegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.register(CustomTabBarCell.self, forCellWithReuseIdentifier: CustomTabBarCell.identifier)
        tabBar.showsHorizontalScrollIndicator = false
        view.addSubview(tabBar)
        NSLayoutConstraint.activate([
            
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            tabBar.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }

    
    private func CustomCollectionViewFlowLayout()->UICollectionViewFlowLayout{
        let flwLayout = UICollectionViewFlowLayout()
        flwLayout.scrollDirection = .horizontal
        flwLayout.minimumLineSpacing = 5// Adjust spacing
        flwLayout.itemSize = CGSize(width: 110, height: 40)
        return flwLayout
    }

    //MARK: Search Button Action
    @objc func searchButtonTapped(){
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    
    

}


extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabBarCell.identifier, for: indexPath) as! CustomTabBarCell
        cell.label.text = items[indexPath.row]
        cell.label.font = UIFont.systemFont(ofSize: 17,weight: .bold)
        cell.label.minimumScaleFactor = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomTabBarCell {
            cell.label.textColor = .red  // Change selected text color
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomTabBarCell {
            cell.label.textColor = .black  // Restore default color when deselected
        }
    }
}

