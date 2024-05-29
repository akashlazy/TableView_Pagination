//
//  PostViewModel.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import Foundation

class PostViewModel {
    
    // Array to hold the fetched posts
    private var posts: [PostResponse] = []
    
    // Instance of PostRequest to manage pagination state
    private var postRequest = PostRequest()
    
    // Instance of PostResource to handle API requests
    private let postResource = PostResource()
    
    // Closure to be called when posts are updated
    var onPostsUpdated: (() -> Void)?
    
    // Closure to be called when an error occurs
    var onError: ((Error) -> Void)?
  
    var numberOfPosts: Int {
        return posts.count
    }
    
    func post(at index: Int) -> PostResponse {
        return posts[index]
    }
        
    func fetchPosts() {
        // Check if a fetch request is already in progress
        guard !postRequest.isFetching else { return }
        
        // Set the isFetching flag to true to indicate a fetch request is in progress
        postRequest.isFetching = true
        
        postResource.getPosts(request: postRequest) { [weak self] result in
            guard let self = self,
                  let newPost = result else { return }
            // Reset the isFetching flag to false as the request has completed
            self.postRequest.isFetching = false
            
            // Check if the result contains new posts
            if !newPost.isEmpty {
                self.posts.append(contentsOf: newPost)
                self.postRequest.currentIndex += 1
                
                // Call the onPostsUpdated closure to update the UI
                self.onPostsUpdated?()
            } else {
                // If no new posts are received, create an error and call the onError closure
                let error = NSError(domain: "Data not received from the server.", code: 1)
                self.onError?(error)
            }
        }
    }
}
