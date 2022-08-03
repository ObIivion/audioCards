//
//  AudioCardsModel.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 25.07.2022.
//

import AVFoundation

struct AudioCardsModel {
    let cardTitle: String
    let audioFile: URL
}

extension ViewController {
    
    func addDataToCards() {
        
        audioCards.append(contentsOf: [
            .init(cardTitle: "Речь - Сплинтера", audioFile: Files.audioExample1),
            .init(cardTitle: "Капельки", audioFile: Files.audioExample2),
            .init(cardTitle: "Black Bird - Regrets", audioFile: Files.audioExample3),
            .init(cardTitle: "Imagine Dragons", audioFile: Files.audioExample4),
            .init(cardTitle: "2 типа людей", audioFile: Files.audioExample5),
            .init(cardTitle: "Nein - Nein", audioFile: Files.audioExample6),
            .init(cardTitle: "zalagasper - Sebi", audioFile: Files.audioExample7),
        ])
    }
}
