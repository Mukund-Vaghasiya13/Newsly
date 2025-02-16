//
//  HomeViewController.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    enum Section{
        case Main
    }
    
    var tabBar:UICollectionView!
    var items = ["Business","Science","Technology","Health","Sports","Entertainment"]
    
    var response:[Article] = []
    var tableView:UITableView!
    var dataSource:UITableViewDiffableDataSource<Section,Article>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguerViewAndNavigationBar()
        ConfigureSubViews()
        FetchNetworkData(title: "general")
        ConfigureDataSource()
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
        
        
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 150
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            tabBar.heightAnchor.constraint(equalToConstant: 55),
            
            tableView.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func ConfigureDataSource(){
        
        dataSource = UITableViewDiffableDataSource<Section,Article>(tableView: self.tableView, cellProvider: { [self] tableView, indexPath, itemIdentifier in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
            cell.ArictleImage.DownloadImage(url: response[indexPath.row].urlToImage ?? "")
            cell.ArticleTitle.text = response[indexPath.row].title
            cell.ArticleDescription.text = response[indexPath.row].description
            
            return cell
            
        })
    }
    
    
    
    
    func FetchNetworkData(title:String){
        
        let url = "top-headlines?category=\(title)&apiKey=750a1ffc45194fe0922a46ad88c2be79"
        
          
       NetworkManager.shared.getNews(url: url) { res in
           switch res{
           case .success(let data):
               self.response = data.articles
               self.UpadteDataSource()
           case.failure(let error):
               print(error)
           }
       }
        
    }

    
    func UpadteDataSource(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Article>()
        snapshot.appendSections([.Main])
        snapshot.appendItems(response)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot)
        }
    }
    
    
    
    private func CustomCollectionViewFlowLayout()->UICollectionViewFlowLayout{
        let flwLayout = UICollectionViewFlowLayout()
        flwLayout.scrollDirection = .horizontal
        flwLayout.minimumLineSpacing = 5// Adjust spacing
        flwLayout.itemSize = CGSize(width: 110, height: 25)
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
            let selected = items[indexPath.row]
            FetchNetworkData(title: selected)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomTabBarCell {
            cell.label.textColor = .black  // Restore default color when deselected
        }
    }
}



extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: response[indexPath.row].url ?? "") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true)
                
    }
}
