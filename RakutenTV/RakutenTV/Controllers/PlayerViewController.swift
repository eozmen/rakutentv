//
//  PlayerViewController.swift
//  RakutenTV
//
//  Created by Queen on 10.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class PlayerViewController: UIViewController {

    let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTimeStart: UILabel!
    @IBOutlet weak var labelTimeEnd: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var viewBigBack: UIView!
    @IBOutlet weak var viewController: UIView!
    
    var playerSliderTimer : Timer?
    var avPlayer : AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    
    private var contentID : String?
    
    private func trackVideoProgress() {
        let interval = CMTime(value: 1, timescale: 1)
        
        avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            self.labelTimeStart.text = String.duration(from: progressTime)
            self.slider.setSliderValue(for: self.avPlayer, progress: progressTime)
            
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status"{
         
            if avPlayer?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                self.trackVideoProgress()
                DispatchQueue.main.async {
                    self.labelTimeEnd.text = String.duration(from: (self.avPlayer?.currentItem?.asset.duration)!)
                    
                }
                
                DispatchQueue.main.async {
                    self.slider.addTarget(self, action: #selector(PlayerViewController.handleSliderChangedValue(sender:)), for: .valueChanged)
                }
                
                
                avPlayer?.play()
                
                self.perform(#selector(hideController), with: nil, afterDelay: 4)
                
                UIView.animate(withDuration: 1, animations: {
                    self.activityIndicator.removeFromSuperview()
                }, completion: { (_) in
                    
                })
                
            }

        }
//        guard keyPath == AVPlayer.observableKey.loadedTimeRanges.rawValue else { return }
        
        guard let duration = avPlayer?.currentItem?.duration else { return }
        labelTimeEnd.text = String.duration(from: duration)
    }
    
    
    @objc func hideController(){
        viewController.isHidden = true
    }
    
    @objc private func handleSliderChangedValue(sender: UISlider) {
        if let duration = avPlayer!.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            avPlayer!.seek(to: seekTime, completionHandler: { (_) in })
        }
        
    }
    func setupPlayerContentID(contentID:String){
        self.contentID = contentID
        
    }
    
    
    @objc func updateTime(){
        let allSeconds = CMTimeGetSeconds(avPlayer!.currentTime())
        slider.value = Float(allSeconds)

        DispatchQueue.main.async {
            self.labelTimeStart.text = String.duration(from: self.avPlayer!.currentTime())
        }
    }
    
    func setPlayerInfromations(streamModel: StreamingModel){
        
        if let model = streamModel.streamInfoList?.first, let urlstring = model.url{
            
            //if there is any Stream info,
            //the required player datas will be set
            avPlayer = AVPlayer()
            avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayer!.bounds = self.view.layer.bounds
            viewBigBack.layer.addSublayer(avPlayerLayer!)
            
            //player layer has the same width height with superview,
            //superview is viewBigBack
            avPlayerLayer!.frame = CGRect(x:0,y:0, width:self.viewBigBack.layer.frame.width,height:self.viewBigBack.layer.frame.height)
            
            
            let url = URL(string: urlstring)
            let playerItem = AVPlayerItem(url: url!)
            avPlayer!.replaceCurrentItem(with: playerItem)
            
            playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(), context: nil)
            
            
            //if user taps on the screen, the view , which contains player controllers,
            //should be appear/disappear
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCloseGUIController))
            view.addGestureRecognizer(tapGesture)
            
            
        }
        
    }
    
    
    @objc fileprivate func fetchTrailer(){
        ApiController.rakutenTrailer(contentID: contentID!) { (streamModel, isSucceeded, errorMessage) in
            
            if isSucceeded{
                self.setPlayerInfromations(streamModel : streamModel!)
            }else{
                
                
                DispatchQueue.main.async {
                    self.errorLabel.text = errorMessage
                    self.view.layoutIfNeeded()
                    
                    UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                        //Yellow error view is hidden with bottom constraint
                        //if it is 0, the error view is hidden
                        //if it is greater than 0, the error view is shown
                        self.errorViewBottomConstraint.constant = self.errorLabel.superview!.frame.size.height
                        self.view.layoutIfNeeded()
                    }, completion:nil)
                }
                
            }
        }
    }
    
    
    
    

    @objc func openCloseGUIController(){
        //Hide/Show player controller if user tapped on the screen
        viewController.isHidden = !viewController.isHidden
        
        if viewController.isHidden == false{
            //If user tap on screen to see the player controller,
            //it will disappear again after 4 seconds
            self.perform(#selector(hideController), with: nil, afterDelay: 4)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func pressedClose(_ sender: Any) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector( fetchTrailer), object: nil)

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedPlayStop(_ sender: Any) {
        switch avPlayer!.timeControlStatus {
        case .playing:
            avPlayer!.pause()
        default:
            avPlayer!.play()
        }
        
    }
    
    fileprivate let seekDuration: Float64 = 30
    @IBAction func pressed30secPrev(_ sender: Any) {
        
        let playerCurrentTime = CMTimeGetSeconds(avPlayer!.currentTime())
        var newTime = playerCurrentTime - seekDuration
        
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        avPlayer!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        
    }
    
    @IBAction func pressedSubtitle(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Yellow error view is hidden with bottom constraint
        //if it is 0, the error view is hidden
        //if it is greater than 0, the error view is shown
         self.errorViewBottomConstraint.constant = 0
        
        view.addSubview(activityIndicator)
        
        
        //add activityindicator autolayout constraints
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        slider.value = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchTrailer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        avPlayer?.pause()
        
        if avPlayer != nil{
            avPlayer?.replaceCurrentItem(with: nil)
            avPlayer = nil
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return isBeingDismissed ? .portrait : .landscapeRight
    }
    
    
}

extension PlayerViewController : AVAudioPlayerDelegate{
    
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("\(error)")
    }
    
}

extension String {
    
    static func duration(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let secondsText = String(format: "%02d", Int(totalSeconds) % 60)
        let minutesText = String(format: "%02d", Int(totalSeconds) / 60)
        return  "\(minutesText):\(secondsText)"
    }
    
}

extension UISlider {
    
    func setSliderValue(for player: AVPlayer?, progress: CMTime) {
        
        if player == nil{
            return
        }
        guard let duration = player!.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let progressSeconds = CMTimeGetSeconds(progress)
        self.value = Float(progressSeconds / totalSeconds)
    }
    
}

