//
//  ArtistCell.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class ArtistCell: UICollectionViewCell {
    
    var artist: Artist? {
        didSet {
            nameLabel.text = artist?.name
            genreLabel.text = artist?.genre
            
            if let url = artist?.imageUrl {
                self.imageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "art1"))
            }
        }
    }
    
    let cornerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.sizeToFit()
        label.numberOfLines = 1
        return label
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
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        containerView.addSubview(cornerView)
        cornerView.fillSuperview()
        
        cornerView.addSubview(imageView)
        imageView.fillSuperview()
        
        cornerView.addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 30))
        
        cornerView.addSubview(genreLabel)
        genreLabel.anchor(top: nil, leading: leadingAnchor, bottom: nameLabel.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30))
    }
}
