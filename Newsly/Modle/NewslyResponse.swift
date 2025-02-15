//
//  NewslyResponse.swift
//  Newsly
//
//  Created by Mukund vaghasiya  on 15/02/25.
//

import Foundation

struct NewslyResponse:Codable {
    let totalResults: Int?
    let articles: [Article]
    let status: String?
}
