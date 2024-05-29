//
//  PostCell.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import UIKit

class PostCell: UITableViewCell {
    
    // Outlets for UI components
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ post: PostResponse) {
        self.postTitle.text = post.title
        self.postMessage.text = post.body
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
