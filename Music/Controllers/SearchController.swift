//
//  SearchController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var artists: [Artist] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var query: String = "" {
        didSet {
            searchNavigationView.query = query
        }
    }
    
    var bgColors = [90, 150, 210]
    
    let service = APIService()
    
    lazy var searchNavigationView: SearchNavigationView = {
        let view = SearchNavigationView()
        view.controller = self
        view.query = self.query
        return view
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
        cv.register(ArtistCell.self, forCellWithReuseIdentifier: cellId)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .transparent
        cv.isPagingEnabled = false
        cv.sizeToFit()
        cv.isScrollEnabled = true
        cv.contentInset = UIEdgeInsets(top: 20, left: 6, bottom: 0, right: 6)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 218, green: 197, blue: 215).cgColor, UIColor(red: 214, green: 141, blue: 203).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(searchNavigationView)
        searchNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchNavigationView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArtistCell
        
        cell.artist = artists[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 290)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigateToArtist(artist: artists[indexPath.row])
    }
    
    
    // MARK: - Callback methods
    
    func navigationBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToArtist(artist: Artist?) {
        if let a = artist {
            let artistController = ArtistController()
            artistController.artist = a
            
            service.fetchSongs(addTo: a, with: "lookup?id=\(a.id!)&entity=song&limit=20", completion: { (songs) in
                if songs != nil {
                    artistController.songs = songs!
                    self.navigationController?.pushViewController(artistController, animated: true)
                }
            })
            
        }
    }
    
}
