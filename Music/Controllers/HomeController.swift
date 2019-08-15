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
        fetchArtists()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(homeView)
        homeView.fillSuperview()
        
        
    }
    
    // MARK: - Fetch Artists
    
    func fetchArtists() {
        let service = APIService()
        service.fetchArtists(with: "search?media=music&entity=musicArtist&limit=20&term=ma", completion: { (artists) in
            if artists != nil {
                print(artists)
            }
        })
    }
    
    // MARK: - Alert
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Callback methods
    func navigateToSearch(searchQuery: String?) {
        if let query = searchQuery, query != "" {
            let searchController = SearchController()
            searchController.query = query
            navigationController?.pushViewController(searchController, animated: true)
        }
    }


}

