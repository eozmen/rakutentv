//
//  MainScreenVC.swift
//  RakutenTV
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

    private var listViewModels : [ListViewModel] = []

    
    //I mostly create all the views programmatically,
    //Storyboard can be very complicating for basic view controllers
    //with code, it is easy to change the Cell Views for me
    //
    //Main Screen , Detail Screen , All Content Views  is created with code
    //Player Controller is created with Storyboard
    //
    
    let topBarView : TopBarView = {
       let view = TopBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        return view
    }()
    
    
    fileprivate func fetchList(){
        
        ApiController.rakutenLists { (list, isSucceeded, errorMessage) in
            
            if isSucceeded {
                //I could not find how to create main page example lists,
                //So I manuelly created with a promo list, and normal movie lists
                //with same sources and titles
                //it was the basic solution for me
                self.listViewModels = []
                self.listViewModels.append(ListViewModel(list: list!))
                self.listViewModels.append(ListViewModel(list: list!))
                self.listViewModels.append(ListViewModel(list: list!))
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    

    func pressedShowAll(listViewModel: ListViewModel) {
        //This function called from "Show All >" buttons ,which each row has it next to title
        let viewController = AllContentVC()
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.setupViews(listViewModel: listViewModel)
        
    }
    
    
    func pressedContentItem(contentViewModel: ContentViewModel){
        //When a user tap on a content in promo line or other movie list,
        //this function called
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(DetailCollectionVC.self)") as! DetailCollectionVC
        viewController.firstSet(contentID: contentViewModel.contentID, snapShotImage: contentViewModel.snapShotImage)
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchList()
    }
    
    
    func setupViews(){
        self.view.backgroundColor = rakutenBackgroundDarkGray
        
        view.addSubview(collectionView)
        view.addSubview(topBarView)
        
        //to set the safearea and the superview constraints for topbar
        //need to know the top anchor value
        //with iPhoneX, safe area need to be calculated for autolayout,
        //otherwise topbar can be not visible clearly for iPhoneX
        let window = UIApplication.shared.keyWindow
        var topAnchorValue : CGFloat = 0
        if let topAnchor = window?.safeAreaInsets.top{
            topAnchorValue = topAnchor
        }
        
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorValue).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: TOPBARHEIGHT).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: topBarView.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        if let bottomPadding = window?.safeAreaInsets.bottom{
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -bottomPadding,right: 0)
            
        }
        
        self.collectionView.register(PromoContentListCell.self, forCellWithReuseIdentifier: "\(PromoContentListCell.self)")
        self.collectionView.register(ContentListCell.self, forCellWithReuseIdentifier: "\(ContentListCell.self)")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        
        //With yOffSet, while user scrolling the movie collection,
        //there will be a blurred view under the topBar
        //The values are in Defines.swift file
        let yOffset : CGFloat = TOPBARHEIGHT
        self.collectionView.contentInset = UIEdgeInsets(top: yOffset, left: 0, bottom: 0, right: 0)
    }
    
    //MainScreen only suports Portrait Orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool{
        return true
    }
    
}




extension MainScreenVC : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //First row of the collectionview is Promo list with snapshot images
        //Other rows are the list of the contents with a title, "Show All" button and artwork images,
        
        if indexPath.row == 0{//PROMO
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PromoContentListCell.self)", for: indexPath) as! PromoContentListCell
            cell.listViewModel = listViewModels[indexPath.row]
            cell.pressedContentItem = { contentViewModel in
                //if user tap on a content, this function will be called
                //this function will show the detail of the movie
                self.pressedContentItem(contentViewModel: contentViewModel)
            }
            return cell
        }
        
        
        //CONTENTLISTS
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ContentListCell.self)", for: indexPath) as! ContentListCell
        cell.listViewModel = listViewModels[indexPath.row]
        cell.pressedContentItem = { contentViewModel in
            //if user tap on a content, this function will be called
            //this function will show the detail of the movie
            self.pressedContentItem(contentViewModel: contentViewModel)
        }
        
        cell.pressedShowAll = { listViewModel in
            //if user tap on a "Show me all" button next to list title, this function will be called
            //this function will show the all contents of that list with another view
            self.pressedShowAll(listViewModel: listViewModel)
        }
        return cell
    }

    
}



extension MainScreenVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Promo row has another row height value
        //The values are in Defines.swift file
        if indexPath.row == 0{ //PROMO
            let width = UIScreen.main.bounds.width
            let height = PROMO_HEIGHT
            return CGSize(width: width, height: height)
        }
        //Other rows have other same height value
        //It calculated with contentcollection height plus title labels height
        //The values are in Defines.swift file
        let width = UIScreen.main.bounds.width
        let height = CELCONTENTHEIGHT + MAINSCREENROWTITLEHEIGHT
        return CGSize(width: width, height: height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
