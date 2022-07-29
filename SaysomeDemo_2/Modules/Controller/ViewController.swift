//
//  ViewController.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 27.07.2022.
//

import UIKit
import AVFoundation

class ViewController: BaseViewController<AudioStoriesView> {
    
    var audioCards: [AudioCardsModel] = []
    
    var audioPlayer = AVAudioPlayer()
    
    var currentCell = AudioStoriesViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .darkGray
        
        addDataToCards()
        
        mainView.audioCardsCollectionView.delegate = self
        mainView.audioCardsCollectionView.dataSource = self
        mainView.audioCardsCollectionView.register(AudioStoriesViewCell.self, forCellWithReuseIdentifier: AudioStoriesViewCell.identifier)
    
    }
    
    func setupAudioPlayer(for url: URL) {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.currentTime = 0
            audioPlayer.prepareToPlay()
            self.audioPlayer = audioPlayer
        } catch let error as NSError {
            print("Unable to activate audio session:  \(error.localizedDescription)")
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return audioCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 120, height: UIScreen.main.bounds.height/1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AudioStoriesViewCell.identifier, for: indexPath) as! AudioStoriesViewCell
        
        cell.prepareForAnimation()
        cell.setModel(model: audioCards[indexPath.item])
        if indexPath.section == 0 && indexPath.item == 0 {
            currentCell = cell
            setupAudioPlayer(for: currentCell.audioFile)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            currentCell.pauseAnimation()
        } else {
            audioPlayer.play()
            currentCell.resumeAnimation()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        audioPlayer.stop()
        
        let myCollection = scrollView as! UICollectionView
        
        let centerXofVisibleCells = myCollection.contentOffset.x + myCollection.frame.size.width / 2
        myCollection.visibleCells.forEach { cell in

            if cell.frame.midX - centerXofVisibleCells < 1 && cell.frame.midX - centerXofVisibleCells > -1 {
                self.currentCell = cell as! AudioStoriesViewCell

                setupAudioPlayer(for: currentCell.audioFile)
                audioPlayer.play()
                
                currentCell.layoutIfNeeded()
                currentCell.prepareForAnimation()
                currentCell.startAnimation(audioPlayer: audioPlayer)
                currentCell.layoutIfNeeded()
            }
        }
    }
}



