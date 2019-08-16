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
    
    let cornerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hex: 0xF9A200)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .transparent
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10))
        
        containerView.addSubview(cornerView)
        cornerView.fillSuperview()
        
        cornerView.addSubview(searchTextField)
        searchTextField.fillSuperview()
        
    }
    
    // MARK: - TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        controller.navigateToSearch(searchQuery: searchTextField.text)
        return false
    }
}
