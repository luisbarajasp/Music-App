//
//  FavsView.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class FavsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var controller: FavsController!
    
    var songs: [Song] = [] {
        didSet{
            setUpViews()
            collectionView.reloadData()
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "Favorites"
        return label
    }()
    
    let headerView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .transparent
        return iv
    }()
    
    lazy var closeButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(self.closeButtonPressed), for: .touchDown)
        b.setImage(UIImage(named: "close"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        return b
    }()
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(SongCell.self, forCellWithReuseIdentifier: cellId)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .transparent
        cv.isPagingEnabled = false
        cv.sizeToFit()
        cv.isScrollEnabled = true
        cv.contentInset = UIEdgeInsets(top: 20, left: 6, bottom: 0, right: 6)
        
        return cv
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.text = "You don't have any favorited song yet, to select one press the heat next to it."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
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
        backgroundColor = .transparent
        
        addSubview(headerView)
        headerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 0, height: 100))
        
        headerView.addSubview(nameLabel)
        nameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        addSubview(closeButton)
        closeButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0), size: CGSize(width: 30, height: 50))
        
        addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        if(songs.count < 1) {
            addSubview(emptyLabel)
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            emptyLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
        }else{
            emptyLabel.removeFromSuperview()
        }
        
    }
    
    @objc
    func closeButtonPressed() {
        controller.closePressed()
    }
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongCell
        
        cell.song = songs[indexPath.row]
        cell.controller = self.controller
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 12, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        controller.navigateToSong(song: songs[indexPath.row])
    }
    
}
