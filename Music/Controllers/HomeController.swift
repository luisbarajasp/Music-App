//
//  ViewController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView()
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
        
        view.addSubview(homeView)
        homeView.fillSuperview()
        
        
    }
    
    // MARK: - Callback methods
    func navigateToSearch(searchQuery: String?) {
        if let query = searchQuery {
            let searchController = SearchController()
            searchController.query = query
            navigationController?.pushViewController(searchController, animated: true)
        }
    }


}

