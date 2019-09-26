//
//  AllContentVC.swift
//  RakutenTV
//
//  Created by Queen on 11.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class AllContentVC: UIViewController {
    
    
    var contentViewModels : [ContentViewModel]?
    
    let cellID = "\(ContentCell.self)"
    let CELLSPACING : CGFloat = 10
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = rakutenBackgroundDarkGray
    }
    
    
    func pressedContentItem(contentViewModel: ContentViewModel){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(DetailCollectionVC.self)") as! DetailCollectionVC
        viewController.firstSet(contentID: contentViewModel.contentID, snapShotImage: contentViewModel.snapShotImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    func setupViews(listViewModel : ListViewModel){
        
        self.contentViewModels = []
        
        
        //Viewmodels of each Content Cells are created here
        
        for item in listViewModel.contents{
            self.contentViewModels?.append(ContentViewModel(contentModel: item))
        }
        
        
        view.addSubview(collectionView)
        
        
        let backButton = BackButton()
        view.addSubview(backButton)
        
        backButton.pressed = {
            [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        
        
        collectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        let window = UIApplication.shared.keyWindow
        if let bottomPadding = window?.safeAreaInsets.bottom{
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -bottomPadding,right: 0)
            
        }
        
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)
        
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
    }
    
    //AllContent only suports Portrait Orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
}



extension AllContentVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentViewModels!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ContentCell
        cell.contentViewModel = contentViewModels![indexPath.row]
        
        return cell
    }
    
}

extension AllContentVC : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //this method called the Detail Screen
        pressedContentItem(contentViewModel: contentViewModels![indexPath.row])
    }
}

extension AllContentVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //The values are in Defines.swift file
        return CELLSPACING
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CELLSPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Depends on numberOfSets we can show 2 contents each row
        //Or another number of contents with spaces
        //The values are in Defines.swift file
        let numberOfSets : CGFloat = 2
        let width = (collectionView.frame.size.width - numberOfSets * CELLSPACING) / numberOfSets
        return CGSize(width: width, height: CELCONTENTHEIGHT)
    }
    
    
}
