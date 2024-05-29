//
//  PostResponse.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import Foundation

struct PostResponse: Decodable {
    let userID: Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
