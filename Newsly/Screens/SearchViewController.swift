//
//  SearchViewController.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 14/02/25.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, UITableViewDelegate {

    
    enum Section {
        case Main
    }
    
    var textField = NLyTextField(placeHolder: "Search 🔎")
    var searchBtn = NLyButton(title: "Search",bgColor: .systemGreen,fontSize: 16)
    var tableView = UITableView()
    var dataSource:UITableViewDiffableDataSource<Section,Article>!
    var response:[Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfiguerViewAndNavigationBar()
        ConfigureSubViews()
        ConfigureTableViewDataSource()
        
    }
    
    func ConfiguerViewAndNavigationBar(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search News 🔎"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .label
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func ConfigureSubViews(){
        view.addSubview(textField)
        
        textField.delegate = self
        
        view.addSubview(searchBtn)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        
        
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
            textField.widthAnchor.constraint(equalTo: searchBtn.widthAnchor,multiplier: 2),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        searchBtn.addTarget(self, action: #selector(SearchBtnPressed), for: .touchUpInside)
        
        

    }
    
    @objc func SearchBtnPressed(){
        guard let textFieldText = textField.text else {return}
        FetchNetworkData(title: textFieldText)
    }
    
    
    func ConfigureTableViewDataSource(){
        dataSource = UITableViewDiffableDataSource<Section,Article>(tableView: tableView, cellProvider: {[self] tableView, indexPath, itemIdentifier in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
            cell.ArictleImage.DownloadImage(url: response[indexPath.row].urlToImage ?? "")
            cell.ArticleTitle.text = response[indexPath.row].title
            cell.ArticleDescription.text = response[indexPath.row].description
            return cell
            
        })
    }
    
    func UpdateTableView(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Article>()
        snapshot.appendSections([.Main])
        snapshot.appendItems(response)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot)
        }
    }
    
    
    func FetchNetworkData(title:String){
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd"
        let yesterdayString = formate.string(from: yesterday)
       
        
        
        let url = "everything?q=\(title)&from=\(yesterdayString)&sortBy=popularity&apiKey=750a1ffc45194fe0922a46ad88c2be79"
        
          
       NetworkManager.shared.getNews(url: url) { res in
           switch res{
           case .success(let data):
               self.response = data.articles
               self.UpdateTableView()
           case.failure(let error):
               print(error)
           }
       }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: response[indexPath.row].url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        navigationController?.present(vc, animated: true)
    }
}



extension SearchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            FetchNetworkData(title: text)
        }
        return true
    }
}

