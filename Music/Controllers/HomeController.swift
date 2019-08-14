//
//  ViewController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var homeNavigationBar: HomeNavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpViews()
        
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        homeNavigationBar = HomeNavigationBar()
        
        view.addSubview(homeNavigationBar)
        homeNavigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        // homeNavigationBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }


}

