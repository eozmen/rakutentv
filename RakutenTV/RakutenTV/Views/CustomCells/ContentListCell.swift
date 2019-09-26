//
//  ContentListCell.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ContentListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var pressedContentItem : ((_ contentViewModel:ContentViewModel) -> Void)?
    var pressedShowAll : ((_ list:ListViewModel) -> Void)?
    
    
    var listViewModel : ListViewModel? {
        didSet{
            
            contentTitleLabel.text = "Estrenos imprescindibles en TAQUILLA"
            
            showAllButton.pressed = {[weak self] in
                
                guard let strongSelf = self else { return }
                strongSelf.pressedShowAll!(strongSelf.listViewModel!)
            }
        }
    }
    let cellID = "\(ContentCell.self)"
    
    let contentTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.numberOfLines = 0
        return label
    }()
    
    let showAllButton : ShowAllListButton = {
        let button = ShowAllListButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        return button
    }()
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ContentCell

        cell.contentViewModel = ContentViewModel(contentModel: listViewModel!.contents[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: CELCONTENTWIDTH, height: CELCONTENTHEIGHT)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel!.contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        pressedContentItem!(ContentViewModel(contentModel: listViewModel!.contents[indexPath.row]))
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    override func setupViews(){
        
        contentView.layoutMargins = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(contentTitleLabel)
        addSubview(collectionView)
        addSubview(showAllButton)
        
        contentTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        contentTitleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        contentTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        contentTitleLabel.heightAnchor.constraint(equalToConstant: MAINSCREENROWTITLEHEIGHT).isActive = true
        contentTitleLabel.trailingAnchor.constraint(equalTo: showAllButton.leadingAnchor, constant: 0).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        
        
        showAllButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        showAllButton.centerYAnchor.constraint(equalTo:contentTitleLabel.centerYAnchor, constant: 0).isActive = true
        showAllButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentTitleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        showAllButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
        
    }
    
}
