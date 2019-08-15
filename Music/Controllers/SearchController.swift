//
//  SearchController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    var query: String = "" {
        didSet {
            searchNavigationView.query = query
        }
    }
    
    lazy var searchNavigationView: SearchNavigationView = {
        let view = SearchNavigationView()
        view.controller = self
        view.query = self.query
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(searchNavigationView)
        searchNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
    }
    
    
    // MARK: - Callback methods
    
    func navigationBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
