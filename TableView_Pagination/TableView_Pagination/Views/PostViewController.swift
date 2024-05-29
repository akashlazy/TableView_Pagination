//
//  PostViewController.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import UIKit

class PostViewController: UIViewController {
    
    // Outlets for UI components
    @IBOutlet weak var postTableView: UITableView!
    
    private let postVM = PostViewModel()
    private var debounceTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Posts"
        
        setDelegates()
        bindViewModel()
        
        // Fetch initial posts
        postVM.fetchPosts()
    }
    
    private func setDelegates() {
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    // Bind the view model's updates to the view controller's UI updates
    private func bindViewModel() {
        postVM.onPostsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.hideFooterView()
                self?.postTableView.reloadData()
            }
        }
        
        postVM.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.hideFooterView()
                self?.showErrorAlert(error: error)
            }
        }
    }
    
    private func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Create a footer view with a loading indicator
    private func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = footerView.center
        activityIndicator.startAnimating()
        footerView.addSubview(activityIndicator)
        return footerView
    }
    
    private func showFooterView() {
        DispatchQueue.main.async {
            self.postTableView.tableFooterView = self.createFooterView()
        }
    }
    
    private func hideFooterView() {
        self.postTableView.tableFooterView = nil
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postVM.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
            let post = postVM.post(at: indexPath.row)
            cell.configure(post)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailPostViewController") as? DetailPostViewController {
            let post = postVM.post(at: indexPath.row)
            vc.postDetails = post
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    // Handle scroll events to implement pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Check if the user has scrolled to the bottom of the table view
        if offsetY > contentHeight - height {
            self.debounceScroll()
        }
    }
    
    // Debounce the scroll event to prevent multiple fetch requests
    private func debounceScroll() {
        debounceTimer?.invalidate()
        self.showFooterView()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.postVM.fetchPosts()
        }
    }
}

