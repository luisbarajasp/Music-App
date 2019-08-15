//
//  SearchNavigationBar.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class SearchNavigationView: UIView {
    
    var controller: SearchController!
    
    var query: String = "" {
        didSet {
            queryLabel.text = query
        }
    }
    
    let queryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var backButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(self.backButtonPressed), for: .touchDown)
        b.setImage(UIImage(named: "back"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        return b
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
        addSubview(backButton)
        backButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0), size: CGSize(width: 30, height: 0))
        
        addSubview(queryLabel)
        queryLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        queryLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        queryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc
    func backButtonPressed() {
        controller.navigationBackPressed()
    }
}
