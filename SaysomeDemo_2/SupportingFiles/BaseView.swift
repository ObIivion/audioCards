//
//  BaseView.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 19.07.2022.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSetup(){
        
    }

}
