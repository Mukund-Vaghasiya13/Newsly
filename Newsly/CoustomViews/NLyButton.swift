//
//  NLyButton.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 16/02/25.
//

import UIKit

class NLyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        ConfigureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title:String,bgColor:UIColor,fontSize:CGFloat){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        ConfigureButton()
    }
    
    override var isHighlighted: Bool{
        didSet{
            alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    private func ConfigureButton(){
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
    
}
