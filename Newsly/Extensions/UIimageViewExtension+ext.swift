//
//  UIimageViewExtension+ext.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 16/02/25.
//

import UIKit

extension UIImageView {
    func DownloadImage(url:String){
    
        if let image = NetworkManager.shared.chache.object(forKey: url as NSString){
            self.image = image
        }else{
            guard let endpoint = URL(string: url) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: endpoint) { data, response, error in
                
                if let _ = error { return }
                
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {return}
                
                guard let data = data else { return }
                
                if let image = UIImage(data: data){
                    NetworkManager.shared.chache.setObject(image, forKey: url as NSString)
                    DispatchQueue.main.async{
                        self.image = image
                    }
                }
                
            }
            
            task.resume()
        }
    
    }
}


