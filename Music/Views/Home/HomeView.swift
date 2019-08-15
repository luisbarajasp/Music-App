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
    
    let cellId = "cellId"
    
    let headerId = "headerId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.register(HomeCollectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.isPagingEnabled = false
        cv.sizeToFit()
        cv.isScrollEnabled = true
        cv.contentInset = UIEdgeInsets(top: 100, left: 16, bottom: 0, right: 16)
        
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
        
        addSubview(collectionView)
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        addSubview(browseLabel)
        browseLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 35))
        
        addSubview(popularLabel)
        popularLabel.anchor(top: browseLabel.bottomAnchor, leading: browseLabel.leadingAnchor, bottom: nil, trailing: browseLabel.trailingAnchor, padding: UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 30))
    }
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .red
        
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
    
    // MARK: - ScrollView DidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= 0 ) {
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: min(-scrollView.contentOffset.y, 100), left: 0, bottom: 0, right: 0)
        }
    }
}
