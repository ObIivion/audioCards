//
//  AudioStoriesView.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 19.07.2022.
//

import UIKit

class AudioStoriesView: BaseView {

    let audioCardsCollectionView: UICollectionView = {
        let layout = AudioStoriesCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        view.backgroundColor = .clear
        view.isSpringLoaded = false
        view.decelerationRate = .fast
        view.collectionViewLayout.invalidateLayout()
        return view
    }()
    
    override func initSetup() {
        addSubview(audioCardsCollectionView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        audioCardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            audioCardsCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            audioCardsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            audioCardsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            audioCardsCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/1.3)
        ])
        
    }
    
}
