//
//  DetailsViewController.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    // Outlets for UI components
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    var postDetails: PostResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure postDetails is not nil before proceeding
        guard let post = postDetails else {
            return
        }
        
        self.title = "\(post.id)"
        
        titleLabel.text = post.title
        messageTextView.text = post.body
    }
}
