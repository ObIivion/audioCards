//
//  Collection.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 31.07.2022.
//

import Foundation

extension Array {
    func at(_ index: Int) -> Element? {
        
        guard index >= 0, index < self.count else { return nil }
        return self[index]
    }
}
