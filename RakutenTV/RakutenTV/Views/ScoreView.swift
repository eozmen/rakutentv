//
//  ScoreView.swift
//  RakutenTV
//
//  Created by Queen on 7.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit

class ScoreView: BaseView {

    let circleProgressView : CircularProgressView = {
        let view = CircularProgressView.init(frame: CGRect(x:0,y:0,width: 70,height:70))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelScore : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19.0, weight: UIFont.Weight(rawValue: 2))
        label.textColor = .white
        label.textAlignment = .center
        label.text = "3.2"
        return label
    }()
    
    let imageVote : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icn_detail_avatar")
        imageView.setImageColor(color: rakutenGrayIcon)
        return imageView
    }()
    
    let labelVote : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "5.9K"
        return label
    }()
    
    let imageSource : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    func loadViews(model: ContentModel){
        labelScore.text = model.score?.score
        labelVote.text = model.score?.formatted_amount_of_votes
        
    }
    
    var scoreViewModel : ScoreViewModel?{
        didSet{
            labelScore.text = scoreViewModel?.scoreString
            labelVote.text = scoreViewModel?.voteString
            imageSource.imageFromURL(urlString: scoreViewModel?.imageString, defaultImage: nil, overlayColor: rakutenGrayIcon)
            
            if let val = scoreViewModel?.scoreString{
                
                if let n = NumberFormatter().number(from: val) {
                    let scoreFloat = CGFloat(truncating: n)
                    circleProgressView.progressAnimation(duration: 1, progressValue: scoreFloat/10.0)
                }
                
                
                UIView.animate(withDuration: 10, delay: 0, options: [], animations: {
                    
                    self.circleProgressView.progressLayer.strokeColor = rakutenScoreGreen.cgColor
                }, completion: nil)
                
            }
        }
    }
    
    override func setupViews(){
        
        
        addSubview(circleProgressView)
        addSubview(labelScore)
        addSubview(imageVote)
        addSubview(labelVote)
        addSubview(imageSource)
        
        addConstraintsWithFormat("H:|-[v0(70)]",views:circleProgressView)
        addConstraintsWithFormat("V:|-[v0(70)]", views: circleProgressView)
        
        labelScore.leadingAnchor.constraint(equalTo: circleProgressView.leadingAnchor, constant: 0).isActive = true
        labelScore.trailingAnchor.constraint(equalTo: circleProgressView.trailingAnchor, constant: 0).isActive = true
        labelScore.bottomAnchor.constraint(equalTo: circleProgressView.centerYAnchor, constant: 0).isActive = true
        labelScore.heightAnchor.constraint(equalToConstant: 20)
        
        imageVote.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageVote.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imageVote.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 3).isActive = true
        imageVote.trailingAnchor.constraint(equalTo: labelScore.centerXAnchor, constant: -5).isActive = true
        
        labelVote.heightAnchor.constraint(equalToConstant: 10).isActive = true
        labelVote.centerYAnchor.constraint(equalTo: imageVote.centerYAnchor, constant: 0).isActive = true
        labelVote.leadingAnchor.constraint(equalTo: imageVote.trailingAnchor, constant: 0).isActive = true
        
        imageSource.centerXAnchor.constraint(equalTo: circleProgressView.centerXAnchor, constant: 0).isActive = true
        imageSource.topAnchor.constraint(equalTo: circleProgressView.bottomAnchor, constant: 15).isActive = true
        imageSource.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageSource.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }


}
