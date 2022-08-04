//
//  AudioStoriesViewCell.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 29.07.2022.
//

import UIKit
import AVFoundation

protocol ProgressCellDelegate {
    
    func updateTimeProgress()
    var progress: Double {get set}
    
}

class AudioStoriesViewCell: BaseViewCell {
    
    var delegate: ProgressCellDelegate?
    
    static let identifier = "Audio Cell"
    
    private let viewMask = UIView()
    private let gradient = CAGradientLayer()
    
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
    
    func updateMask() {
        
        guard let unwrappedDelegate = delegate else {return}
        
        let newFrameWidth = indicatorLabelWhite.bounds.size.width * unwrappedDelegate.progress
        
        self.viewMask.frame = CGRect(x: self.indicatorLabelWhite.bounds.origin.x,
                                     y: self.indicatorLabelWhite.bounds.origin.y,
                                     width: newFrameWidth,
                                     height: self.indicatorLabelWhite.bounds.size.height)
    }
    
    func prepareMask() {
        
        viewMask.frame = CGRect(
            x: indicatorLabelWhite.bounds.origin.x,
            y: indicatorLabelWhite.bounds.origin.y,
            width: 0,
            height: indicatorLabelWhite.bounds.size.height)
        
        viewMask.backgroundColor = .black
        indicatorLabelWhite.mask = viewMask
    }
    
    func setModel(model: AudioCardsModel) {
        
        indicatorLabelWhite.text = model.cardTitle
        indicatorLabelBlack.text = model.cardTitle
    }
}
