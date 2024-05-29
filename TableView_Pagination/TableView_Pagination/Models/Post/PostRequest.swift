//
//  PostRequest.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import Foundation

struct PostRequest: Encodable {
    var currentIndex: Int = 1
    let maxLimit: Int = 10
    var isFetching: Bool = false
}
