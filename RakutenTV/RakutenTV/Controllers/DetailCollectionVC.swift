//
//  DetailCollectionVC.swift
//  RakutenTV
//
//  Created by Queen on 6.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailCollectionVC: UICollectionViewController {

    //
    //loadingView will contain activityIndicator
    //While detail of the movie is fetched from API
    //
    let loadingView : UIView = {
        let view = UIView()
        view.backgroundColor = rakutenBackgroundDarkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var detailViewModel : DetailViewModel? {
        didSet{
        
            
            //Some Contents does not have score value
            //If showScore is false
            //cellHeights row has no ScoreCell height value
            //cellIdentifiers has no ScoreListCell identifier value
            //
            //Depends on cellIdentifiers I can control collectionViews contentSize and row datas
            //
            if detailViewModel!.showScore == false{
                cellHeights = [CELLHEIGHT_TRAILER,CELLHEIGHT_INFORMATION, 150 ,80,250]
                cellIdentifiers = ["\(DetailTrailerCell.self)","\(DetailInformationCell.self)","\(DetailDescriptionCell.self)","\(GenreListCell.self)","\(ActorListCell.self)"]
            }else{
                cellHeights = [CELLHEIGHT_TRAILER, CELLHEIGHT_INFORMATION,  150,CELLHEIGHT_SCORES ,80,250]
                cellIdentifiers = ["\(DetailTrailerCell.self)","\(DetailInformationCell.self)","\(DetailDescriptionCell.self)","\(ScoreListCell.self)","\(GenreListCell.self)","\(ActorListCell.self)"]
            }
            
            
            self.collectionItemsCount = self.cellIdentifiers.count
            
            DispatchQueue.main.async {
                
                //detailViewModel is set , it means data fetching completed and
                //it is time to
                //remove activity indicator and hide its superview(loadingView)
                UIView.animate(withDuration: 1, animations: {
                    self.activityIndicator.removeFromSuperview()
                    self.loadingView.alpha = 0
                }, completion: { (_) in
                    self.loadingView.removeFromSuperview()
                })
                
                //start to load the datasource
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    //it is height constraint of the contentImageView
    //With this constraint the black contentImageOverlay effect
    //will be seen while scrolling after awhile
    @IBOutlet weak var contentImageConstraint: NSLayoutConstraint!
    
    
    //If the user scrolls too much, this overlay will be seen
    @IBOutlet weak var contentImageOverlay: UIView!
    
    
    //The max height value of contentImageView
    private let contentImageHeightLimit : CGFloat = 300
    
    //The value, which decided when the overlay will be seen and
    //control the value of alpha ratio
    //to have smooth animation
    private let contentImageAlphaLimit : CGFloat = 200
    
    
    private let itemsPerRow: CGFloat = 1
    private var firstContentID : String?
    private var firstImageSnapshot : String?
    
    var cellIdentifiers : [String] = []
    var cellHeights : [CGFloat] = []
    var collectionItemsCount = 0
    
    //MARK:Class Methods
    
    
    func firstSet(contentID: String?, snapShotImage: String?){
        self.firstContentID = contentID
        self.firstImageSnapshot = snapShotImage
    }
    
    func registerCellClasses(){
        
        //Register which cells will be seen in this collectionview
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(DetailTrailerCell.self, forCellWithReuseIdentifier: "\(DetailTrailerCell.self)")
        self.collectionView!.register(DetailInformationCell.self, forCellWithReuseIdentifier: "\(DetailInformationCell.self)")
        self.collectionView!.register(DetailDescriptionCell.self, forCellWithReuseIdentifier: "\(DetailDescriptionCell.self)")
        self.collectionView!.register(ScoreListCell.self, forCellWithReuseIdentifier: "\(ScoreListCell.self)")
        self.collectionView!.register(GenreListCell.self, forCellWithReuseIdentifier: "\(GenreListCell.self)")
        self.collectionView!.register(ActorListCell.self, forCellWithReuseIdentifier: "\(ActorListCell.self)")
        
        //Registerin the Play Content CollectionCell
        self.collectionView!.register(DetailFooterView.self,forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(DetailFooterView.self)")
        
    }
    
    fileprivate func fetchContent(){
        ApiController.rakutenMovie(contentID: firstContentID!, completion: { (model, isSucceeded, errorMessage) in
            if isSucceeded {
                self.detailViewModel = DetailViewModel(movieModel: model!)
            }
        })
    }
    
    
    @objc func playTrailer(){
        //if the user tapped on trailer button
        //PlayerViewController will be seen
        let storyBoard = UIStoryboard.init(name: "PlayerGUI", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "\(PlayerViewController.self)") as! PlayerViewController
        
        self.present(viewController, animated: true, completion: nil)
        viewController.setupPlayerContentID(contentID: detailViewModel!.movieModel.contentID!)

    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //I control which cell will be seen when, with cellidentifiers array
        //Because some contents does not have Score data
        //With indexPath row it cause crushes
        //So it is the best way to controll cells
        
        let cellIdentifier = cellIdentifiers[indexPath.row]
        
        if cellIdentifier == "\(DetailTrailerCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! DetailTrailerCell
            
            cell.trailerButton.pressed = { [weak self] in
                
                guard let strongSelf = self else { return }
                NSObject.cancelPreviousPerformRequests(withTarget: strongSelf, selector: #selector( strongSelf.playTrailer), object: nil)
                strongSelf.perform(#selector( strongSelf.playTrailer), with: nil, afterDelay: 0.3)
            }
            
            return cell
        }
        
        if cellIdentifier == "\(DetailInformationCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! DetailInformationCell
            cell.informationViewModel = InformationViewModel(movieModel: detailViewModel!.movieModel)
            return cell
        }
        
        if cellIdentifier == "\(DetailDescriptionCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! DetailDescriptionCell
            cell.descriptionViewModel = DescriptionViewModel(movieModel: detailViewModel!.movieModel)
            return cell
        }
        
        if cellIdentifier == "\(ScoreListCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! ScoreListCell
            cell.ScoreListViewModel = ScoreListViewModel(movieModel: detailViewModel!.movieModel)
            return cell
        }
        
        if cellIdentifier == "\(GenreListCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! GenreListCell
            cell.genreListViewModel = GenreListViewModel(movieModel: detailViewModel!.movieModel)
            
            return cell
        }
        if cellIdentifier == "\(ActorListCell.self)" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! ActorListCell
            cell.actorListViewModel = ActorListViewModel(movieModel: detailViewModel!.movieModel)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionFooter:
            
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(DetailFooterView.self)",
                    for: indexPath) as? DetailFooterView
                else {
                    fatalError("Invalid view type")
            }
            headerView.setupViews()
            
            return headerView
        case UICollectionView.elementKindSectionHeader:
            
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(CustomHeaderView.self)",
                    for: indexPath) as? CustomHeaderView
                else {
                    fatalError("Invalid view type")
            }
            
            return headerView
        default:
            
            assert(false, "Invalid element type")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchContent()
    }
    
    
    func setupViews(){
        
        contentImageView.imageFromURL(urlString: firstImageSnapshot!, defaultImage: nil, overlayColor: nil)
        
        collectionView.backgroundColor = rakutenBackgroundDarkGray
        
        let backButton = BackButton()
        
        backButton.pressed = {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        
        view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        view.addSubview(backButton)
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: 0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor, constant: 0).isActive = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionFootersPinToVisibleBounds = true
        }
        
        //BottomPadding is necessery for not causing a gap for iPhoneX
        let window = UIApplication.shared.keyWindow
        if let bottomPadding = window?.safeAreaInsets.bottom{
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -bottomPadding,right: 0)
        }
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)
        
        //This 2 lines are necessery for a dynamic row height
        //Movie Descriptions length are different
        //So detail screens description are different
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        
        registerCellClasses()
        
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //With this function overlay for contentImageView and the height is controlled
        
        
        let offset = scrollView.contentOffset
        let newHeight = contentImageHeightLimit - offset.y
        contentImageConstraint.constant = newHeight
        
        if newHeight < contentImageAlphaLimit{
            //User scrolled down too much
            //passed the limit
            //So overlay will be shown smootly with the ratio control
            let ratio = (contentImageAlphaLimit - newHeight) / contentImageAlphaLimit
            contentImageOverlay.alpha = ratio
        }else{
            contentImageOverlay.alpha = 0
        }
        
        
        var compareValue = collectionView.contentSize.height - view.frame.size.height
        
        let window = UIApplication.shared.keyWindow
        if let topPadding = window?.safeAreaInsets.top{
            compareValue -= topPadding
        }
        
        if offset.y > compareValue {
            scrollView.contentOffset = CGPoint(x:0,y:compareValue)
        }
    }
    //DetailCollection only suports Portrait Orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool{
        return true
    }
    
}





extension DetailCollectionVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let availableWidth = collectionView.frame.size.width
        let widthPerItem = availableWidth / itemsPerRow        
        
        var heightPerItem = cellHeights[indexPath.row]
        
        if cellIdentifiers[indexPath.row] == "\(DetailDescriptionCell.self)" {
            
            //only the description cell's height changes
            
            let cell = DetailDescriptionCell.init(frame: CGRect(x:0, y:0, width:collectionView.frame.size.width , height: 100)) as DetailDescriptionCell
            cell.descriptionViewModel = DescriptionViewModel(movieModel: detailViewModel!.movieModel)
            heightPerItem = cell.contentTitleLabel.intrinsicContentSize.height + cell.contentDescriptionLabel.intrinsicContentSize.height + 10
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: DETAILFOOTERHEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: contentImageHeightLimit)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}





class CustomHeaderView: UICollectionReusableView {
    
}



