//
//  ViewController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    lazy var homeNavigationView: HomeNavigationView = {
        let view = HomeNavigationView()
        view.controller = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpViews()
        
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(homeNavigationView)
        homeNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        // homeNavigationBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    // MARK: - Callback methods
    func navigateToSearch() {
        if let query = homeNavigationView.searchTextField.text {
            let searchController = SearchController()
            searchController.query = query
            navigationController?.pushViewController(searchController, animated: true)
        }
    }


}

