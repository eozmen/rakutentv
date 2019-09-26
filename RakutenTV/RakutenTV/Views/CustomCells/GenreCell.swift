//
//  GenreCell.swift
//  RakutenTV
//
//  Created by Queen on 9.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit


class GenreCell: BaseCell{
    
    
    let genreTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()

    let genreImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        
        return imageView
    }()
    
    var genreViewModel : GenreViewModel? {
        didSet{
            genreTitle.text = genreViewModel?.titleString
            genreImage.imageFromURL(urlString: genreViewModel?.imageString, defaultImage: nil, overlayColor: rakutenGrayIcon)
            
        }
    }
    override func setupViews(){
        
        self.backgroundColor = rakutenCellBackground
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = 15
        
        addSubview(genreTitle)
        addSubview(genreImage)


        genreImage.frame = CGRect(x:0,y:0,width:30,height: 30)
        genreTitle.frame = CGRect(x: 40, y:0,width:self.frame.size.width - 40 ,height:30)
        
        
        
        genreTitle.preferredMaxLayoutWidth = 100
    }
    
}

