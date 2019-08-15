//
//  HomeCollectionView.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class HomeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var controller: HomeController!
    
    var artists: [Artist] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var bgColors = [240, 120, 160]
    // 140 100 240
    
    let browseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.text = "Browse"
        label.sizeToFit()
        
        return label
    }()
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.text = "Popular"
        label.sizeToFit()
        
        return label
    }()
    
    let statusBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let cellId = "cellId"
    
    let headerId = "headerId"
    
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
        cv.register(HomeCollectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.isPagingEnabled = false
        cv.sizeToFit()
        cv.isScrollEnabled = true
        cv.contentInset = UIEdgeInsets(top: 100, left: 6, bottom: 0, right: 6)
        
        return cv
    }()
    
    var browseLabelTop: NSLayoutConstraint!
    var popularLabelTop: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        addSubview(collectionView)
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        addSubview(browseLabel)
        browseLabel.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 35))
        
        // 50 normal
        browseLabelTop = browseLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50)
        browseLabelTop.isActive = true
        
        addSubview(popularLabel)
        popularLabel.anchor(top: nil, leading: browseLabel.leadingAnchor, bottom: nil, trailing: browseLabel.trailingAnchor, size: CGSize(width: 0, height: 30))
        
        // 165 normal
        popularLabelTop = popularLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 165)
        popularLabelTop.isActive = true
        
        
        
        addSubview(statusBarBackgroundView)
        statusBarBackgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.topAnchor, trailing: trailingAnchor)
        
        
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
        
//        cell.imageView.image = UIImage(named: "art1")
        
//        cell.genreLabel.text = artists[indexPath.row].genre
//        cell.nameLabel.text = artists[indexPath.row].name
        
        cell.artist = artists[indexPath.row]
        
        // apply background to cell
        /*let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 145, green: 97, blue: 250).cgColor, UIColor(red: 100, green: 77, blue: 200).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = cell.cornerView.bounds
        gradientLayer.borderWidth = cell.cornerView.layer.borderWidth
        gradientLayer.cornerRadius = cell.cornerView.layer.cornerRadius
        
        cell.cornerView.layer.insertSublayer(gradientLayer, at: 0)*/
        let red: CGFloat = CGFloat(bgColors[0]) - (CGFloat(indexPath.row) * 5)
        let green: CGFloat = CGFloat(bgColors[1] - indexPath.row)
        let blue: CGFloat = CGFloat(bgColors[2]) + (CGFloat(indexPath.row) * 4)
        
        cell.cornerView.backgroundColor = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.width - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HomeCollectionHeaderCell
            
            header?.controller = self.controller
            
            return header!
        }
        
        assert(false, "Invalid element type")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let red: CGFloat = CGFloat(bgColors[0]) - (CGFloat(indexPath.row) * 5)
        let green: CGFloat = CGFloat(bgColors[1] - indexPath.row)
        let blue: CGFloat = CGFloat(bgColors[2]) + (CGFloat(indexPath.row) * 4)
        
        controller.navigateToArtist(artist: artists[indexPath.row], backgroundColor: UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1))
    }
    
    // MARK: - ScrollView DidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= 0 ) {
            scrollView.contentInset = UIEdgeInsets.zero
            
            if (scrollView.contentOffset.y >= 30 ) {
                browseLabelTop.constant = -50
                popularLabelTop.constant = -50
            } else {
                // browseLabel topAnchor
                browseLabelTop.constant = -scrollView.contentOffset.y - 50
                
                // popularLabel topAnchor
                popularLabelTop.constant = browseLabelTop.constant + 115
            }
            
        }else{
            // browseLabel topAnchor
            browseLabelTop.constant = -scrollView.contentOffset.y - 50
            
            // popularLabel topAnchor
            popularLabelTop.constant = browseLabelTop.constant + 115
            
            // collectionview content inset
            scrollView.contentInset = UIEdgeInsets(top: min(-scrollView.contentOffset.y, 100), left: 0, bottom: 0, right: 0)
        }
    }
}
