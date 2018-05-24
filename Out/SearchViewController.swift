//
//  SearchViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 4/20/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: OG Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SearchBar
    func setupSearchBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.barStyle = .default
        searchController.searchBar.placeholder = "Search for Cities"
        
        // Styles for the textfield that is presented for the searchBar
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .white
            textfield.resignFirstResponder()
            // self.view.tintColor assigns color to the cursor, in this case its assigning iOS default blue color.
            textfield.tintColor = self.view.tintColor

            if let backgroundview = textfield.subviews.first {

                // Background color
                backgroundview.backgroundColor = .white

                // Rounded corners for the textfield
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        navigationItem.searchController = searchController
    }    

    @IBAction func cancelSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
