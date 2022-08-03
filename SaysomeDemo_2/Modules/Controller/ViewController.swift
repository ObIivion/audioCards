//
//  ViewController.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 27.07.2022.
//

import UIKit
import AVFoundation

class ViewController: BaseViewController<AudioStoriesView>, ProgressCellDelegate {
    
    var progress: Double = 0.0
    
    var audioCards: [AudioCardsModel] = []
    
    private var audioPlayer = AVAudioPlayer()
    
    private var currentCell = AudioStoriesViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .darkGray
        
        addDataToCards()
        
        mainView.audioCardsCollectionView.delegate = self
        mainView.audioCardsCollectionView.dataSource = self
        mainView.audioCardsCollectionView.register(AudioStoriesViewCell.self, forCellWithReuseIdentifier: AudioStoriesViewCell.identifier)
    }
    
    private func setupAudioPlayer(for url: URL) {
        
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
    
    func updateTime(){
        
        if audioPlayer.isPlaying {
            
            progress = audioPlayer.currentTime / audioPlayer.duration
            currentCell.updateMask()
            print("progress updated: \(progress * 100)" )
            DispatchQueue.main.async { [weak self] in
                self?.updateTime()
            }
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
        
        cell.prepareMask()
        cell.setModel(model: audioCards[indexPath.item])
        if indexPath.section == 0 && indexPath.item == 0 {
            currentCell = cell
            currentCell.delegate = self
            setupAudioPlayer(for: currentCell.audioFile)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !audioPlayer.isPlaying  {
            audioPlayer.play()
            updateTime()
            print("resume animation")
        } else {
            audioPlayer.pause()
            
            print("pause animation")
            print(progress * 100)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let myCollection = scrollView as! UICollectionView
        
        let centerXofVisibleCells = myCollection.contentOffset.x + myCollection.frame.size.width / 2
        myCollection.visibleCells.forEach { cell in

            if cell.frame.midX - centerXofVisibleCells < 1 && cell.frame.midX - centerXofVisibleCells > -1 {
                currentCell = cell as! AudioStoriesViewCell
                currentCell.delegate = self
                setupAudioPlayer(for: currentCell.audioFile)
                audioPlayer.play()
                updateTime()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentCell.prepareMask()
        audioPlayer.pause()
    }
}



