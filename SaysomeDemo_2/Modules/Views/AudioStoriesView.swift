//
//  AudioStoriesView.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 19.07.2022.
//

import UIKit

class AudioStoriesView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "SomeSay"
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 35)
        
        return view
    }()

    let audioCardsCollectionView: UICollectionView = {
        let layout = AudioStoriesCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 45
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        view.backgroundColor = .clear
        view.isSpringLoaded = false
        view.decelerationRate = .fast
        
        return view
    }()
    
    override func initSetup() {
        addSubview(titleLabel)
        addSubview(audioCardsCollectionView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        audioCardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audioCardsCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            audioCardsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            audioCardsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            audioCardsCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/1.3)
        ])
        
    }
    
}
