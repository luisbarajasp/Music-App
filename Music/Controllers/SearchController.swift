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
        cv.backgroundColor = .white
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
        view.backgroundColor = .white
        view.addSubview(searchNavigationView)
        searchNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchNavigationView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
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
        
        let red: CGFloat = CGFloat(bgColors[0]) - (CGFloat(indexPath.row) * 5)
        let green: CGFloat = CGFloat(bgColors[1] - indexPath.row)
        let blue: CGFloat = CGFloat(bgColors[2]) + (CGFloat(indexPath.row) * 4)
        
        cell.cornerView.backgroundColor = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.width - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let red: CGFloat = CGFloat(bgColors[0]) - (CGFloat(indexPath.row) * 5)
        let green: CGFloat = CGFloat(bgColors[1] - indexPath.row)
        let blue: CGFloat = CGFloat(bgColors[2]) + (CGFloat(indexPath.row) * 4)
        
        navigateToArtist(artist: artists[indexPath.row], backgroundColor: UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1))
    }
    
    
    // MARK: - Callback methods
    
    func navigationBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToArtist(artist: Artist?, backgroundColor: UIColor = .white) {
        if let a = artist {
            let artistController = ArtistController()
            artistController.artist = a
            artistController.artistColor = backgroundColor
            print(a)
            service.fetchSongs(addTo: a, with: "lookup?id=\(a.id!)&entity=song&limit=20", completion: { (songs) in
                if songs != nil {
                    artistController.songs = songs!
                    self.navigationController?.pushViewController(artistController, animated: true)
                }
            })
            
        }
    }
    
}
