//
//  ViewController.swift
//  TMBoard-4.0
//
//  Created by satish bisa on 5/10/21.
//

import UIKit
import AVFoundation
import NVActivityIndicatorView

class ViewController: UIViewController, CAAnimationDelegate {

   
    var player: AVAudioPlayer?
    var videoPlayer: AVPlayer?
    
    
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
        return gradientLayer
    }()
    
    let buttonOne: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        //label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return label
    }()
    
    let filterBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
        v.layer.borderWidth = 2
        v.backgroundColor = .black
        v.clipsToBounds = true
        v.layer.cornerRadius = 12
        v.isHidden = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    let continueBtn: UIButton = {
        let v = UIButton(frame: CGRect(x: 0, y: 100, width: 320, height: 200))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        v.layer.borderWidth = 2
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = v.bounds
        v.layer.addSublayer(gradient)
        v.clipsToBounds = true
        v.layer.cornerRadius = 40
        v.isHidden = false
        v.isUserInteractionEnabled = true
        //v.addTarget(self, action: #selector(segueToBoard), for: .touchUpInside)
        return v
    }()
    
    let continueBtnLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 75, y: 100, width: 320, height: 200))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.center = CGPoint(x: 300, y: 285)
        lbl.textAlignment = .center
        lbl.text = "CONTINUE"
        lbl.font = UIFont(name: "Aquino-Demo", size: 25)
        lbl.textColor = .systemRed
        return lbl
    }()
    
    let secondButton: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 200))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
        v.layer.borderWidth = 2
        
        
        
        
        //v.backgroundColor = .black
        let gradient = CAGradientLayer()
        
  
        
        //gradient.frame = v.bounds
        gradient.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = v.bounds
        v.layer.addSublayer(gradient)
        
      
        
        
        
        
        //v.layer.insertSublayer(gradient, at: 0)
        v.clipsToBounds = true
        v.layer.cornerRadius = 12
        v.isHidden = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //continueBtn.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(segueToBoard)))
        continueBtn.addTarget(self, action: #selector(segueToBoard), for: .touchUpInside)
        view.addSubview(continueBtn)
        continueBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
        continueBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        continueBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        continueBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(continueBtnLbl)
        
        continueBtnLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
        continueBtnLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        continueBtnLbl.heightAnchor.constraint(equalToConstant: 75).isActive = true
        continueBtnLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        playBackgroundVideo()
       // setupView()
       // playHomeVideo()
    }
    
    @IBAction func stopMusic(_ sender: Any) {
        player?.stop()
    }
    
    
    func playHomeVideo(){
        //playWalkman()
        let path = Bundle.main.path(forResource: "homeScreenTMG", ofType: "mp4")
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        videoPlayer!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        videoPlayer!.seek(to: CMTime.zero)
        videoPlayer!.play()
        self.videoPlayer?.isMuted = true
    }
    //
    func playBackgroundVideo(){
        playWalkman()
        let path = Bundle.main.path(forResource: "cuttingMeat2", ofType: "mp4")
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        videoPlayer!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        videoPlayer!.seek(to: CMTime.zero)
        videoPlayer!.play()
        self.videoPlayer?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd(){
        videoPlayer!.seek(to: CMTime.zero)
    }
    
    func setupView(){
        filterBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buckleYourSeatbelt)))
        secondButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iLikeDudesALot)))
        filterBackgroundView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = filterBackgroundView.bounds
        view.addSubview(filterBackgroundView)
        view.addSubview(secondButton)
        filterBackgroundView.addSubview(buttonOne)
        buttonOne.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        buttonOne.center = view.center
        
        
        filterBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        filterBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
        filterBackgroundView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        filterBackgroundView.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
        
        secondButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        secondButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 230).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        secondButton.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
    }
    
    @objc private func segueToBoard(){

        print("Performing segue!")
       // self.performSegue(withIdentifier: "TMBoard", sender: nil)
        player?.stop()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TMBoard") as! TMBoard
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    @objc private func playWalkman(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "walkman", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
    
    @objc private func buckleYourSeatbelt(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "buckleYourSeatbelt", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
    @objc private func iLikeDudesALot(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "iLikeDudesAlot", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
}

extension ViewController {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
                print("flag")
        }
    }
}
