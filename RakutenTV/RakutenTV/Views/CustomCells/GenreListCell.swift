//
//  GenreListCell.swift
//  RakutenTV
//
//  Created by Queen on 9.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class GenreListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var genreListViewModel : GenreListViewModel? {
        didSet{
            
            collectionView.reloadData()
        }
    }
    let cellID = "\(GenreCell.self)"
    
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
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 30)
        
        let view:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GenreCell
        cell.genreViewModel = GenreViewModel(genreModel: self.genreListViewModel!.genres[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cell = GenreCell.init(frame: CGRect(x:0, y:0, width:100, height: 30)) as GenreCell
        
        cell.genreViewModel = GenreViewModel(genreModel: self.genreListViewModel!.genres[indexPath.row])
        
        let widthPerItem = cell.genreTitle.intrinsicContentSize.width + cell.genreImage.frame.size.width + 20
        
        return CGSize(width: widthPerItem, height: 30)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genreListViewModel!.genres.count
    }
    
    
    override func setupViews(){
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: cellID)
        
        contentView.addSubview(contentTitleLabel)
        contentView.addSubview(collectionView)
        
        contentTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        contentTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        contentTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        
        
        
        collectionView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        
        
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        contentTitleLabel.text = "Genres"
        
        
    }
    
}


