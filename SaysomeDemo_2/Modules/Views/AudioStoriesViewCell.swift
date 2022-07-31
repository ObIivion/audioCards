//
//  AudioStoriesViewCell.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 29.07.2022.
//

import UIKit
import AVFoundation

class AudioStoriesViewCell: BaseViewCell {
    
    static let identifier = "Audio Cell"
    
    private(set) var isAnimationStarted = false
    
    private let viewMask = UIView()
    private let gradient = CAGradientLayer()
    
    var audioFile = URL(fileURLWithPath: "")
    
    private let indicatorLabelWhite: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 30)
        view.textColor = .white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indicatorLabelBlack: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 30)
        view.textColor = .black
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func initSetup() {
        
        createGradientLayer()
        addSubview(indicatorLabelBlack)
        addSubview(indicatorLabelWhite)
        setupConstraints()
        
        
           
    }
    
    private func createGradientLayer() {

        gradient.colors = [UIColor.brown.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = 25
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            indicatorLabelWhite.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorLabelWhite.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            indicatorLabelBlack.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorLabelBlack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    func prepareForAnimation() {
        
        viewMask.frame = CGRect(
            x: indicatorLabelWhite.bounds.origin.x,
            y: indicatorLabelWhite.bounds.origin.y,
            width: 0,
            height: indicatorLabelWhite.bounds.size.height)
        
        viewMask.backgroundColor = .black
        indicatorLabelWhite.mask = viewMask
        
        indicatorLabelWhite.layer.timeOffset = 0
        indicatorLabelWhite.layer.speed = 1
        indicatorLabelWhite.layer.beginTime = 0
    }
    
    func startAnimation(audioPlayer: AVAudioPlayer?){
        isAnimationStarted = true
        self.layoutIfNeeded()
        UIView.animate(withDuration: audioPlayer!.duration, animations: {
            self.viewMask.frame = CGRect(x: self.indicatorLabelWhite.bounds.origin.x, y: self.indicatorLabelWhite.bounds.origin.y, width: self.indicatorLabelWhite.bounds.size.width, height: self.indicatorLabelWhite.bounds.size.height)
        }, completion: {_ in 
            self.prepareForAnimation()
            self.isAnimationStarted = false
        })
        self.layoutIfNeeded()
    }
    
    func resumeAnimation(){
        
        let pausedTime = indicatorLabelWhite.layer.timeOffset
        indicatorLabelWhite.layer.timeOffset = pausedTime
        indicatorLabelWhite.layer.speed = 1
        indicatorLabelWhite.layer.beginTime = 0
        let timeSincePause = indicatorLabelWhite.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        indicatorLabelWhite.layer.beginTime = timeSincePause
    }
    
    func pauseAnimation(){
        
        let pausedTime = indicatorLabelWhite.layer.convertTime(CACurrentMediaTime(), from: nil)
        indicatorLabelWhite.layer.speed = 0
        indicatorLabelWhite.layer.timeOffset = pausedTime
    }
    
    func setModel(model: AudioCardsModel) {
        
        indicatorLabelWhite.text = model.cardTitle
        indicatorLabelBlack.text = model.cardTitle
        audioFile = model.audioFile  
    }
    
}
