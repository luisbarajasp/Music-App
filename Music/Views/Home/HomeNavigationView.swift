//
//  HomeNavigationBar.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeNavigationView: UIView, UITextFieldDelegate {
    
    var controller: HomeController!
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.text = "Welcome to Music!"
        label.sizeToFit()
        
        return label
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.contentVerticalAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.returnKeyType = .done
        tf.delegate = self
        tf.placeholder = "Search for artists..."
        tf.clearButtonMode = .always
        tf.returnKeyType = .search
        
        tf.sizeToFit()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
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
        addSubview(welcomeLabel)
        welcomeLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        addSubview(searchTextField)
        searchTextField.anchor(top: welcomeLabel.bottomAnchor, leading: welcomeLabel.leadingAnchor, bottom: bottomAnchor, trailing: welcomeLabel.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        
        
    }
    
    // MARK: - TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        controller.navigateToSearch()
        return false
    }
}
