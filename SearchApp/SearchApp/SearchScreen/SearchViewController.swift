//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import UIKit

class SearchViewController: UITableViewController {

    // MARK:- Variables -
    
    private var resultSearchController = UISearchController()
    private let viewModel = SearchViewModel()
    
    private lazy var delayHandler = Throttler(seconds: 0.3)
    
    private let cellIdentifier = "resultCell"
    
    private let serialQueue = DispatchQueue(label: "com.demo.tableSerialQueue")
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitials()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    // MARK:- Helpers -
    
    func dataBindings() {
        
        viewModel.viewModelCallbacks.bind {[weak self] value in
            
            if let _ = value as? SearchViewModelErrors {
                
                self?.refreshTableView()
            }
            else if let _ = value as? SearchMessages {
                
                self?.refreshTableView()
            }
        }
    }
    
    private func setupNavigationBar() {
        
        let color = UIColor(red: 25.0/255.0, green: 48.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        let lightColor = UIColor(red: 48.0/255.0, green: 69.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        
        var attr = [NSAttributedString.Key: Any]()
        attr[.foregroundColor] = UIColor.white
        attr[.font] = UIFont.systemFont(ofSize:18, weight:.heavy)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = attr
        
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
                
        setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = .white
        
        resultSearchController.searchBar.searchBarStyle = .minimal
        resultSearchController.searchBar.backgroundColor = color
        resultSearchController.searchBar.tintColor = .white
        resultSearchController.searchBar.searchTextField.backgroundColor = lightColor
    }
}


// MARK:- Table Helpers -

extension SearchViewController {
    
    func setupInitials() {
        
        self.title = "Search"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dataBindings()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        refreshTableView()
    }
    
    func refreshTableView() {
        
        serialQueue.async {[weak self] in
            
            self?.moveToMainThread({[weak self] in
                
                self?.tableView.reloadData()
            })
        }
    }
}

extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.totalResults()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let tableCell = cell as? ResultTableViewCell,
           let result = viewModel.resultForIndex(indexPath.row) {
            
            tableCell.populateInfo(result)
        }
        
        let total = viewModel.totalResults()
        
        if total > 0,
            indexPath.row == total - 1 {
            viewModel.getNextSearchResults(forSearchText: resultSearchController.searchBar.text)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text ?? ""
        
        delayHandler.throttle {[weak self] in
            
            print("search text = \(searchText)")
            
            self?.viewModel.getFreshSearchResults(forSearchText: searchText)
        }
    }
}
