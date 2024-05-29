//
//  PostResource.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import Foundation

struct PostResource {
    
    // Get posts based on the given PostRequest
    func getPosts(request: PostRequest, completionHandler: @escaping(_ result: [PostResponse]?) -> Void) {

        // Construct the API URL using the current index and maximum limit from the request
        let apiUrl = "\(API.posts)\(request.currentIndex)&_limit=\(request.maxLimit)"

        var urlRequest = URLRequest(url: URL(string: apiUrl)!)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        APIService.shared.call(urlRequest: urlRequest, resultType: [PostResponse].self) { (postResponse) in
            completionHandler(postResponse)
        }
    }
}
