//
//  PromoContentListCell.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class PromoContentListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var pressedContentItem : ((_ contentViewModel:ContentViewModel) -> Void)?
    
    
    var listViewModel : ListViewModel? {
        didSet{
            
            collectionView.reloadData()
        }
    }
    
    let cellID = "\(PromoContentCell.self)"
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PromoContentCell
        
        if let model = listViewModel?.contents[indexPath.row]{
            cell.contentViewModel = ContentViewModel(contentModel:model)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.size.width, height: PROMO_HEIGHT)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel?.contents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = listViewModel?.contents[indexPath.row]{
            
            pressedContentItem!(ContentViewModel(contentModel:model))
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    override func setupViews(){
        collectionView.register(PromoContentCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.isPagingEnabled = true
        
        
        
    }
    
}
