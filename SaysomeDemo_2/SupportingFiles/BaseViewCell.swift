//
//  BaseViewCell.swift
//  SaysomeDemo_2
//
//  Created by Павел Виноградов on 29.07.2022.
//

import UIKit

class BaseViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        awakeFromNib()
        initSetup()
    }
    
    func initSetup() {
        
    }
    
}
