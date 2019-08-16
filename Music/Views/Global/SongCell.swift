//
//  SongCell.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    var controller: UIViewController!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.favButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        let origImage = UIImage(named: "heart")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    var song: Song? {
        didSet{
            if let s = song {
                imageView.loadImageUsingCacheWithURLString(s.imageUrl!, placeHolder: UIImage(named: "art1"))
                nameLabel.text = s.name
                
                if song!.isFav {
                    let origImage = UIImage(named: "heart-filled")
                    let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                    favButton.setImage(tintedImage, for: .normal)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        clipsToBounds = true
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, size: CGSize(width: 60, height: 0))
        
        addSubview(favButton)
        favButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 25, height: 0))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: imageView.bottomAnchor, trailing: favButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    @objc
    func favButtonPressed() {
        
        if song!.isFav {
            let origImage = UIImage(named: "heart")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            favButton.setImage(tintedImage, for: .normal)
        }else {
            let origImage = UIImage(named: "heart-filled")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            favButton.setImage(tintedImage, for: .normal)
        }
        
        if let cont = controller as? ArtistController {
            cont.setSongFav(id: song!.id!, fav: !song!.isFav)
        }
        if let cont = controller as? FavsController {
            cont.setSongFav(id: song!.id!, fav: !song!.isFav)
        }
    }
}
