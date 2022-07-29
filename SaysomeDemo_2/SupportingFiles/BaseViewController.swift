//
//  BaseViewController.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 19.07.2022.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    
    var mainView: T { view as! T }
    
    override func viewDidLoad() {
        view = T()
    }
    
}
