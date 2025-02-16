//
//  NLyTextField.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 16/02/25.
//

import UIKit

class NLyTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ConfigureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder:String){
        super.init(frame: .zero)
        self.placeholder = placeHolder
        ConfigureTextField()
    }
    
    private func ConfigureTextField(){
        translatesAutoresizingMaskIntoConstraints = false
        borderStyle = .roundedRect
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
        returnKeyType = .search
        autocorrectionType = .no
    }
    
}
