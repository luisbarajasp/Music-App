//
//  ArtistView.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class ArtistView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var controller: ArtistController!
    
    var artist: Artist? {
        didSet{
            // Fetch songs
            nameLabel.text = artist!.name
        }
    }
    
    var songs: [Song] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let headerView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .transparent
        return iv
    }()
    
    lazy var backButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(self.backButtonPressed), for: .touchDown)
        b.setImage(UIImage(named: "back"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        return b
    }()
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
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
        
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0), size: CGSize(width: 30, height: 50))
        
        addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc
    func backButtonPressed() {
        controller.navigationBackPressed()
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
        return CGSize(width: collectionView.bounds.width - 12, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
}
