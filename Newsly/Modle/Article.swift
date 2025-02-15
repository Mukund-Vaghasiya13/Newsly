//
//  Article.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 15/02/25.
//

import Foundation


struct Article:Hashable,Codable{
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    let content:String?
    let source:Source?
}
