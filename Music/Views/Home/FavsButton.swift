//
//  FavsButton.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class FavsButton: UIView {
    
    var controller: HomeController!
    
    let cornerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        return view
    }()
    
    lazy var button: UIButton = {
        let b = UIButton()
        
        b.backgroundColor = .transparent
        b.addTarget(self, action: #selector(self.buttonPressed), for: .touchDown)
        
        return b
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        let image = UIImage(named: "heart-filled")?.withRenderingMode(.alwaysTemplate)
        iv.image = image
        iv.tintColor = .white
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        containerView.addSubview(cornerView)
        cornerView.fillSuperview()
        
        cornerView.addSubview(imageView)
        imageView.anchor(top: cornerView.topAnchor, leading: cornerView.leadingAnchor, bottom: cornerView.bottomAnchor, trailing: cornerView.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        
        containerView.addSubview(button)
        button.fillSuperview()
        
    }
    
    @objc
    func buttonPressed() {
        controller.presentFavsController()
    }
}
