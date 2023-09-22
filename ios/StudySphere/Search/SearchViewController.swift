//
//  SearchViewController.swift
//  StudyTogether
//
//  Created by Team 24 on 4/17/23.
//

import UIKit
import ParseSwift

class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    let searchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    //test data
    //var postlist = [Post]()
    //var post = [Post]()
    var filteredPosts = [Post]()
    var refreshControl = UIRefreshControl()
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test data
        //initList()
        
        initSearchController()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //test data
//        func initList() {
//            let data1 = Post(title: "Java OOP", desc: "Java OOP is a core feature of the Java programming language that allows developers to organize code into objects containing properties and methods.")
//            postlist.append(data1)
//            let data2 = Post(title: "SQL Query", desc: "A SQL query is a statement used to retrieve data from a relational database using the SQL language.")
//            postlist.append(data2)
//            let data3 = Post(title: "Java Overload", desc: "Java overload is when you define multiple methods with the same name in a class, but with different parameters.")
//            postlist.append(data3)
//        }
//
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchText(searchText: searchText)
    }
    
    func filterForSearchText(searchText: String) {
            filteredPosts = posts.filter {
                posts in
                if(searchController.searchBar.text != ""){
                    let searchTextMatch = posts.body?.lowercased().contains(searchText.lowercased())
                    return searchTextMatch ?? false
                }
                else {
                    return false
                }
            }
            tableView.reloadData()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryPosts()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func queryPosts() {
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])

        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @IBAction func onLogoutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive){
            return filteredPosts.count
        }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //test data
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        //let thisPost: Post!
        if(searchController.isActive){
            tableViewCell.configure(with: filteredPosts[indexPath.row])
            //thisPost = filteredPosts[indexPath.row]
        } else {
            tableViewCell.configure(with: posts[indexPath.row])
            //thisPost = posts[indexPath.row]
        }
        return tableViewCell
    }
}
