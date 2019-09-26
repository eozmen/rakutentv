//
//  ActorListCell.swift
//  RakutenTV
//
//  Created by Queen on 9.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class ActorListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var actorListViewModel : ActorListViewModel? {
        didSet{
            
            collectionView.reloadData()
        }
    }
    
    let cellID = "\(ActorsCell.self)"
    
    let contentTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight(rawValue: 2.0))
        label.numberOfLines = 0
        return label
    }()
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ActorsCell
        
        if indexPath.section == 0{
            cell.actorViewModel = ActorViewModel(actorModel: self.actorListViewModel!.directors[indexPath.row])
            
        }else if indexPath.section == 1{
            cell.actorViewModel = ActorViewModel(actorModel: self.actorListViewModel!.actors[indexPath.row])
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140.0, height: 200.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.actorListViewModel!.directors.count
        }
        
        return self.actorListViewModel!.actors.count
    }
    
    
    
    
    override func setupViews(){
        
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        
        collectionView.register(ActorsCell.self, forCellWithReuseIdentifier: cellID)
        
        
        contentView.addSubview(contentTitleLabel)
        contentView.addSubview(collectionView)
        
        contentTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        contentTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        contentTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        
        
        
        collectionView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        contentTitleLabel.text = "Reparto"
        
    }
    
}


