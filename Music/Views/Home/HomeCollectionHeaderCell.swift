//
//  HomeNavigationBar.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeCollectionHeaderCell: UICollectionReusableView, UITextFieldDelegate {
    
    var controller: HomeController!
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.contentVerticalAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.returnKeyType = .done
        tf.delegate = self
        tf.placeholder = "Search for artists..."
        tf.clearButtonMode = .always
        tf.returnKeyType = .search
        
        tf.sizeToFit()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFit
        tf.leftView = imageView
        tf.leftViewMode = .always
        
        
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .white
        addSubview(searchTextField)
        searchTextField.fillSuperview()
        
    }
    
    // MARK: - TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        controller.navigateToSearch(searchQuery: searchTextField.text)
        return false
    }
}
